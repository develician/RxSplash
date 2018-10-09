//
//  UnsplashAPI.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import RxAlamofire
import RxSwift
import Alamofire

enum UnsplashAPI {
    case getUnsplashList(page: Int, perPage: Int, orderBy: String)
}

extension UnsplashAPI {
    // local ip를 써주시면 됩니다.
    static let baseURLString: String = "http://192.168.0.23:4000"
    
    var path: String {
        switch self {
        case .getUnsplashList(_, _, _):
            return "/api/unsplash/list"
        }
    }
    
    var url: URLComponents {
        switch self {
        case let .getUnsplashList(page, perPage, orderBy):
            var url = URLComponents(string: "\(UnsplashAPI.baseURLString)\(path)")!
            let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
            let perPageQueryItem = URLQueryItem(name: "perPage", value: "\(perPage)")
            let orderByQueryItem = URLQueryItem(name: "orderBy", value: "\(orderBy)")
            url.queryItems = [pageQueryItem, perPageQueryItem, orderByQueryItem]
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUnsplashList:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getUnsplashList:
            return URLEncoding.default
        }
    }
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    
    func buildRequest(parameters: Parameters) -> Observable<Data> {
        return UnsplashAPI.manager.rx.request(method, url, parameters: parameters, encoding: parameterEncoding, headers: nil)
            .validate(statusCode: 200 ..< 300)
            .data()
            .observeOn(MainScheduler.instance)
    }
    
    
    
}
