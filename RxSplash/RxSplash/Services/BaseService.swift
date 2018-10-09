//
//  BaseService.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
