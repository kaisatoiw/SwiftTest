//
//  ImageModel.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/08.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import Foundation

struct Image: Codable {
    var id: Int?
    var thumb_url: String?
    var small_url: String?
    var order: Int?
    var width: Float?
    var height: Float?
}
