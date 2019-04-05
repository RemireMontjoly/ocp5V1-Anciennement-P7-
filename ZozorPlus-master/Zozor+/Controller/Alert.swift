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
    
    class func showAlert(title: String, message: String, vc: UIViewController) {
        let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        vc.present(alertVC, animated: true, completion: nil)
    }
}







