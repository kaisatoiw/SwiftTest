//
//  PostModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/08.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Foundation

struct Post: Codable {
    var id: Int
    var abstract: String
    var like_count: Int
    var comment_count: Int
    var clip_count: Int
    var is_liked: Bool
    var images: [Image?]
    var product_tags: [ProductTag?]
    var user: User
}
