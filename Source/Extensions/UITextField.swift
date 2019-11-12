//
//  UITextField.swift
//  MedMobilie
//
//  Created by dr.mac on 26/12/18.
//  Copyright © 2018 dr.mac. All rights reserved.
//

import Foundation
import UIKit
import IoniconsKit

public extension UITextField{
    
    func EmailValidation() -> Bool
    {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        if emailTest.evaluate(with: self.text) == false {
            return false
        }
        else
        {
            return true
        }
    }
    
    func PasswordValidation() -> Bool{
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])[a-z\\d$@$#!%*?&]{8,}")
        
        if passwordTest.evaluate(with: self.text) == false {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func PhoneValidation() -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        if phoneTest.evaluate(with: self.text) == false {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    func cornerRadius(value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
    var isNumerics: Bool {
        let characterSet = CharacterSet(charactersIn: "0123456789")
        if self.text?.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        if self.text?.count != 10
        {
            return false
        }
        return true
    }
    func textFieldBottomBorder()
    {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width + 40, height: self.frame.size.height)
        
        border.borderWidth = 0.5
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func Padding () {
        
        let Padding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        self.leftView = Padding
        self.leftViewMode = .always
        
        
    }
    func setImageRightPaddingPoints(_ amount:CGFloat , img : Ionicons) {
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        paddingView.image = UIImage.ionicon(with: img, textColor: .black, size: CGSize(width: paddingView.frame.size.width, height: paddingView.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func BottomBorder () {
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        
    }
}

