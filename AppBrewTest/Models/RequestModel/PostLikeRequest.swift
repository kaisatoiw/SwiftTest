//
//  PostLikeRequest.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/17.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Alamofire

// MARK: - Request
struct PostLikeRequest: RequestProtocol {
    init(param: Parameters? = nil, method: HTTPMethod) {
        self.parameters = param
        self.method = method
    }
    typealias ResponseType = SingleResponse

    var method: HTTPMethod
    
    var path: String {
        return APIConstants.likes.path
    }
    
    var parameters: Parameters?
    
}
