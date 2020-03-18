//
//  RequestProtocol.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/16.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//
import Alamofire

// MARK: - BaseRequestProtocol
protocol RequestProtocol: APIProtocol, URLRequestConvertible {
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension RequestProtocol {
    var encoding: URLEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        // requestごとの　pathを設定
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))

        // requestごとの　methodを設定(get/post/delete etc...)
        urlRequest.httpMethod = method.rawValue
        
        // headersを設定
        urlRequest.allHTTPHeaderFields = headers
        // timeout時間を設定
        urlRequest.timeoutInterval = TimeInterval(10)

        // requestごとの　parameterを設定
        if let params = parameters {
            urlRequest = try encoding.encode(urlRequest, with: params)
        }

        return urlRequest
    }

}
