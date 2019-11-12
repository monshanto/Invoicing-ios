//
//  AlertView.swift
//  MedMobilie
//
//  Created by dr.mac on 26/12/18.
//  Copyright © 2018 dr.mac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func popupAlertWithSheet(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
       

        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
         let action = UIAlertAction(title:  "Dismiss", style: .cancel, handler: nil)
            alert.addAction(action)
        
        if UI_USER_INTERFACE_IDIOM() != .phone {
            alert.popoverPresentationController?.permittedArrowDirections = .up
            var rect = self.view.bounds
            //rect.origin.x = view.frame.size.width
            //rect.origin.y = rect.origin.y + 50
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = rect
        }
       // self.presentViewController(alertController, animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)
    }
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Submit",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}



