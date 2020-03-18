//
//  APIConstants.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/16.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//
import Alamofire
// MARK: - Constants
enum APIConstants {
    case getPosts
    case likes
    // MARK: Public Variables
    public var path: String {
        switch self {
        case .getPosts: return "posts/latest"
        case .likes: return "likes"
        }
    }
    // MARK: Public Static Variables
    public static var baseURL = "https://makestaging.appbrew.io/api/"
    
    public static var header: HTTPHeaders? {
        // 必要ならば個々に設定してください
        return [
            "accept": "*/*",
            "Authorization": "Bearer 47962eae17938ae5a5aebfb90d07fcab1a4ab823c39cee72afd8c824d247ba8ff3e560fa54e0844d0d69d0a328c6d13ef064897c2bc5ac6cffe2c954520beba3"
        ]
    }
}
