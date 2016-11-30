//
//  DateExtensions.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/29/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }
}

extension UIViewController {
    func showAlert(error:Error){
        let myAlert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)

    }
}
