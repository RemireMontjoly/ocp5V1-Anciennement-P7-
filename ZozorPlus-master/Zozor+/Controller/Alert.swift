//
//  Alert.swift
//  CountOnMe
//
//  Created by pith on 29/03/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
// class func showBasic(title: String, message: String, vc: UIViewController) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//        vc.present(alert, animated: true)
//    }
    
    class func showAlert(title: String, message: String, vc: UIViewController) {
        let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        vc.present(alertVC, animated: true, completion: nil)
    }
}






