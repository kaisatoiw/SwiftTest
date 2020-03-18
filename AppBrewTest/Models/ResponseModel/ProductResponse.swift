//
//  ProductModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/09.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Foundation

struct Product: Codable {
    var id: Int
    var name: String
    var brand: Brand?
    var image_url: String?
    var small_image_url: String?
}

struct Category: Codable {
    var id: Int
    var display_name: String
    var name: String
}

struct Brand: Codable {
    var id: Int
    var name: String
}
