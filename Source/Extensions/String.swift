//
//  String.swift
//  MedMobilie
//
//  Created by dr.mac on 27/12/18.
//  Copyright © 2018 dr.mac. All rights reserved.
//

import Foundation
import UIKit
extension String
{
    
    func EmailValidation() -> Bool
    {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        if emailTest.evaluate(with: self) == false {
            return false
        }
        else
        {
            return true
        }
    }
    
   
    
    func stringToDate() -> NSDate
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date  = dateFormatterGet.date(from: self) as? NSDate {
            return date
        } else {
            print("There was an error decoding the string")
        }
        return NSDate()
    }
    
    func DateFormat(FormatType:String) -> String {
        
        
        let date_TimeFormatter = DateFormatter()
        date_TimeFormatter.dateFormat = FormatType
        let strdate_hour = date_TimeFormatter.date(from: self)
        let date_hour = date_TimeFormatter.string(from: strdate_hour ?? Date())
        return date_hour
        
    }
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
//    var languageSet : String{
//         return LocalizationSystem.SharedInstance.localizedStingforKey(key: self, comment: "")
//    }
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.absoluteString ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
    
}
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        
        return Darwin.round(self * divisor) / divisor
    }
    
    
        
    
    
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        //self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
