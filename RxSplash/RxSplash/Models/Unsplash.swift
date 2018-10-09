//
//  Unsplash.swift
//  RxSplash
//
//  Created by killi8n on 04/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit

struct Unsplash: Codable {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let urls: Urls
    let links: Links
    let categories: [String]
    let likes: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case description
        case urls
        case links
        case categories
        case likes
        case user
    }
    
    
}

struct Urls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct Links: Codable {
    let selfLink: String
    let html: String
    let download: String
    let downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}

struct User: Codable {
    let id: String
    let username: String
    let name: String
    let bio: String?
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case bio
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}


