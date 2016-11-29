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

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let url = "http://jsonplaceholder.typicode.com/photos"
    
    func requestPhotos (completion: @escaping ([Photo]?, NSError?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            //test
            let photoArray:[Photo]? = response.result.value
            
            completion(photoArray,nil)
        }
    }
}
