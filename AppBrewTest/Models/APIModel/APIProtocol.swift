//
//  APIProtocol.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/16.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Alamofire

// MARK: - Base API Protocol
protocol APIProtocol {
    associatedtype ResponseType: Codable // レスポンスの型

    var method: HTTPMethod { get } // get,post,delete などなど
    var baseURL: URL { get } // APIの共通呼び出し元。 ex "https://~~~"
    var path: String { get } // リクエストごとのパス
    var decode: (String) throws -> ResponseType { get } // デコードの仕方
}

extension APIProtocol {

    var baseURL: URL { // 先ほど上で定義したもの。
        // 絶対にあることがある保証されているので「try！」を使用している
        return try! APIConstants.baseURL.asURL()
    }

    var headers: HTTPHeaders? { // 先ほど上で定義したもの。なければ「return nil」でok
        return APIConstants.header
    }
    var decode: (String) throws -> ResponseType { // decoderはあとで用意するので注意
        return {
            try JSONDecoder().decode(ResponseType.self, from: ($0.data(using: .utf8))!)
        }
    }
}
