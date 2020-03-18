//
//  GetPostsRequest.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/16.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Alamofire

// MARK: - Request
struct GetPostsRequest: RequestProtocol {
    typealias ResponseType = Posts

    init(param: Parameters? = nil, method: HTTPMethod) {
        self.parameters = param
        self.method = method
    }
    
    var method: HTTPMethod
    
    var path: String { // 先ほど定enumで定義したもの
        return APIConstants.getPosts.path
    }
    
    var parameters: Parameters?
    
}
