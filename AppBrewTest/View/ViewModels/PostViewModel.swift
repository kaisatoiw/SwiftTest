//
//  PostViewModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/17.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Alamofire

struct PostViewModel {
    
    let items = BehaviorRelay<[PostSectionModel]>(value: [])
    let disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var page = BehaviorRelay<Int>(value: 1)
    func updateItems(page: Int = 1) {
        let param: [String: Any] = ["page": page]
        let req = GetPostsRequest(param: param, method: .get)
        APICliant.call(req, disposeBag, onSuccess: { result in
            var ps: [PostItem] = []
            for post in result.posts {
                let item = post.images.isEmpty ? PostItem.postNoImage(post: post) : PostItem.postWithImage(post: post)
                ps.append(item)
            }
            var sections: [PostSectionModel] = self.items.value
            sections.append(PostSectionModel(model: .post, items:ps))
            self.items.accept(sections)
            self.isLoading.accept(false)
        }, onError: { error in
            print(error)
        })
    }
    
    func postLike(id: Int, isLiked: Bool) {
        let param: [String: Any] = ["likeable_type": "Post", "likeable_id": id]
        let req = PostLikeRequest(param: param, method: isLiked ? .post : .delete)
        APICliant.call(req, disposeBag, onSuccess: { result in
            print(result)
        }, onError: { error in
            print(error)
        })
    }
}
