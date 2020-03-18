//
//  PostCellViewModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/17.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import RxSwift
import RxRelay

struct PostCellViewModel {
    let likeState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let likeCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    var id = 0
    let disposeBag = DisposeBag()
    func postLike(id: Int, isLiked: Bool) {
        let param: [String: Any] = ["likeable_type": "Post", "likeable_id": id]
        let req = PostLikeRequest(param: param, method: isLiked ? .delete : .post)
        APICliant.call(req, disposeBag, onSuccess: { result in
            self.likeState.accept(!self.likeState.value)
            self.likeCount.accept(self.likeState.value ? self.likeCount.value + 1 : self.likeCount.value - 1)
        }, onError: { error in
            self.error.accept(error)
        })
    }

    func chngeValue(isLiked: Bool) {
        self.likeState.accept(!isLiked)
        self.likeCount.accept(self.likeCount.value + (isLiked ? 1 : -1))
    }
}
