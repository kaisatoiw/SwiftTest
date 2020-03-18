//
//  MediaModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/08.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Foundation

struct Media: Codable {
    var id: Int
    var url: String
    var thumb_url: String
    var small_url: String?
    var width: Int
    var height: Int
    var order: Int
    var is_image: Bool
}
