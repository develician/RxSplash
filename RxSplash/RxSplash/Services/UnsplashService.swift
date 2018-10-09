//
//  UnsplashService.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import RxSwift
import RxAlamofire
import RxCocoa

protocol UnsplashServiceType {
    var decoder: JSONDecoder { get }
    func getUnsplashList(page: Int, perPage: Int, orderBy: String) -> Observable<[Unsplash]>
}

final class UnsplashService: BaseService, UnsplashServiceType {
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    func getUnsplashList(page: Int, perPage: Int, orderBy: String) -> Observable<[Unsplash]> {
        let parameters: [String: Any] = [:]
        return UnsplashAPI.getUnsplashList(page: page, perPage: perPage, orderBy: orderBy).buildRequest(parameters: parameters).map({ (data) -> [Unsplash] in
            guard let unsplashList = try? self.decoder.decode([Unsplash].self, from: data) else { return [] }
            return unsplashList
        })
    }
    
    
}
