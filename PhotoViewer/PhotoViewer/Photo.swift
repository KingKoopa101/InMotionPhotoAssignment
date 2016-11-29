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
    
    static func getPhotosInOrderByAlbum(unorganizedPhotos: [Photo]) -> [Int:[Photo]] {
        
        var organizedPhotosDict:[Int:[Photo]] = [:]
        var uniqueAlbums:[Int] = []
        
        for photo in unorganizedPhotos{
        
            if let duplicateAlbum : [Photo] = organizedPhotosDict[photo.albumId!]{
                var d : [Photo]  = organizedPhotosDict[photo.albumId!]! as [Photo]
                d.append(photo)
                organizedPhotosDict[photo.albumId!] = d
            }else{
                uniqueAlbums.append(photo.albumId!)
                organizedPhotosDict[photo.albumId!] = [photo]
            }
        }
        

//        let distinctAlbums1 = Set(unorganizedPhotos.map{$0.albumId}) //- wasnt able to get this working because of ObjectMapper implementation
//        
//        for album in distinctAlbums1{
//            let albumPhotos = unorganizedPhotos.filter({ $0.albumId == album})
//            organizedPhotosDict[album] = albumPhotos
//        }
        
        return organizedPhotosDict
    }
    
    func mapping(map: Map) {
        albumId    <- map["albumId"]
        id         <- map["id"]
        thumbnailUrl      <- map["thumbnailUrl"]
        title       <- map["title"]
        url  <- map["url"]
    }
}
