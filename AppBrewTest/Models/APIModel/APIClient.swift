//
//  APIClient.swift
//  AppBrewTest
//
//  Created by Sato on 2020/03/16.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

// MARK: - ResultType
enum APIResult {
    case success(Codable)
    case failure(Error)
}

// MARK: - API Cliant
struct APICliant {
    
    // MARK: Private Static Variables
    private static let successRange = 200..<400
    private static let contentType = ["application/json"]
    
    
    // MARK: Static Methods
    
    // 実際に呼び出すのはこれだけ。（rxを隠蔽化しているだけなので、observeでも大丈夫）
    static func call<T, V>(_ request: T, _ disposeBag: DisposeBag, onSuccess: @escaping (V) -> Void, onError: @escaping (Error) -> Void)
        where T: RequestProtocol, T.ResponseType == V {
            
            _ = observe(request)
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { onSuccess($0) },onError: { onError($0) })
                .disposed(by: disposeBag)
    }
    
    // RxSwiftを導入している部分。成功/失敗いずれかしか返らないSingleにしてある。
    static func observe<T, V>(_ request: T) -> Single<V>
        where T: RequestProtocol, T.ResponseType == V {
            
            return Single.create { observer in
                let caller = callForData(request) { response in
                    switch response {
                    //※ 既にsuccessしているので「as! V」で強制キャストしている（できる）
                    case .success(let result): observer(.success(result as! V))
                    case .failure(let error): observer(.error(error))
                    }
                }
                
                return Disposables.create() {
                    caller.cancel()
                }
            }
    }
    
    // Alamofire呼び出し部分
    private static func callForData<T, V>(_ req: T, completion: @escaping (APIResult) -> Void) -> DataRequest
        where T: RequestProtocol, T.ResponseType == V {
            
            return request(req).responseString { response in
                                switch response.result.flatMap(req.decode) {
                                case .success(let data):
                                    completion(.success(data))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
            }
    }
    
    // Alamofireのメソッドのみ切り出した部分
    private static func request<T>(_ req: T) -> DataRequest
        where T: RequestProtocol {
            return Alamofire
                .request(req)
                .validate(statusCode: successRange)
                .validate(contentType: contentType)
    }
}


// MARK: - JSONDecoder Extension
extension JSONDecoder {
    
    convenience init(type: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = type
    }
    
    static let decoder: JSONDecoder = JSONDecoder(type: .convertFromSnakeCase)
}
