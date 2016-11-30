//
//  Photo.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo : Mappable {
    
    var albumId: Int?
    var id: Int?
    var thumbnailUrl: String?
    var title: String?
    var url: String?
    
    required init?(map: Map) {
        //albumId = try? map.value("name")
    }
    
    func mapping(map: Map) {
        albumId    <- map["albumId"]
        id         <- map["id"]
        thumbnailUrl      <- map["thumbnailUrl"]
        title       <- map["title"]
        url  <- map["url"]
    }
}
