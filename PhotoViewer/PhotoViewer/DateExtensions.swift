//
//  DateExtensions.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/29/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }
}
