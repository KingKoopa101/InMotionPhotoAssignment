//
//  NetworkManager.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

class Cloud {
    
    static let sharedInstance = Cloud()
    
    let url = "http://jsonplaceholder.typicode.com/photos"
    
    func requestPhotos (completion: @escaping ([Photo]?, NSError?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            //test
            let photoArray:[Photo]? = response.result.value
            
            completion(photoArray,nil)
        }
    }
    
    func getAlbums(completion: @escaping ([Int:[Photo]]?, NSError?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            //        if error != nil{
            //        //handle error
            //        }
            
            
            guard let photos :[Photo] = response.result.value else {
                //show("No name to submit")
                completion(nil, NSError())
                return
            }
            
            
            
            var organizedPhotosDict:[Int:[Photo]] = [:]
            var uniqueAlbums:[Int] = []
            
            for photo in photos{
                
                if let duplicateAlbum : [Photo] = organizedPhotosDict[photo.albumId!]{
                    var d : [Photo]  = organizedPhotosDict[photo.albumId!]! as [Photo]
                    d.append(photo)
                    organizedPhotosDict[photo.albumId!] = d
                }else{
                    uniqueAlbums.append(photo.albumId!)
                    organizedPhotosDict[photo.albumId!] = [photo]
                }
            }
            
            completion(organizedPhotosDict,nil)
        }
        //        let distinctAlbums1 = Set(unorganizedPhotos.map{$0.albumId}) //- wasnt able to get this working because of ObjectMapper implementation
        //
        //        for album in distinctAlbums1{
        //            let albumPhotos = unorganizedPhotos.filter({ $0.albumId == album})
        //            organizedPhotosDict[album] = albumPhotos
        //        }
    }
}
