//
//  ServiceProvider.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import Foundation

protocol ServiceProviderType: class {
    var unsplashService: UnsplashServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var unsplashService: UnsplashServiceType = UnsplashService(provider: self)
}
