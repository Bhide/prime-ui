//
//  UIViewController+Extensions.swift
//  Video Streaming App
//
//  Created by Samir on 4/2/22.
//

import Foundation
import UIKit


extension UIViewController{
    
    
    /// Show a simple alert for showing messages
    /// - Parameter message: A text message to be shown on an alert
    func showAlert(message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
}
