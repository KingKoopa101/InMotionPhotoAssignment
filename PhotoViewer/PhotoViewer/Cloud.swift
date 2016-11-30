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
    
    var refreshTime : Date? = nil
    
    let url = "http://jsonplaceholder.typicode.com/photos"
    
    func requestPhotos (completion: @escaping ([Photo]?, NSError?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            if response.result.error != nil {
                completion(nil,response.result.error as NSError?)
            }
            //test
            let photoArray:[Photo]? = response.result.value
            
            completion(photoArray,nil)
        }
    }
    
    func getAlbums(completion: @escaping ([Int:[Photo]]?, Error?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            if response.result.error != nil {
                completion(nil,response.result.error)
            }
            
            guard let photos :[Photo] = response.result.value else {
                completion([:], nil)
                return
            }
            
            
            self.refreshTime = Date()
            completion(self.sortPhotosByAlbum(photos:photos),nil)
        }
    }
    
    /*Putting this function here because ideally the request would take parameters to be able to sort by album and return an "album" array*/
    
    private func sortPhotosByAlbum(photos:[Photo]) -> [Int:[Photo]]{
        var organizedPhotosDict:[Int:[Photo]] = [:]
        var uniqueAlbums:[Int] = []
        
        for photo in photos{
            
            if let duplicateAlbum : [Photo] = organizedPhotosDict[photo.albumId!]{
                var duplicateAlbumMutableCopy : [Photo] = duplicateAlbum 
                duplicateAlbumMutableCopy.append(photo)
                organizedPhotosDict[photo.albumId!] = duplicateAlbumMutableCopy
            }else{
                uniqueAlbums.append(photo.albumId!)
                organizedPhotosDict[photo.albumId!] = [photo]
            }
        }
        return organizedPhotosDict
    }
    
    func downloadRequest(){
        /*WIP: trying to use alamo fire download to store locally with object mapper, not sure if possible, can fall back on manually saving .plist*/
        Alamofire.download(url).responseData { response in
            if let data = response.result.value {
                
            }
        }
    }
}
