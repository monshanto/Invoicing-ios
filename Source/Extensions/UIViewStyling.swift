//
//  UIViewStyling.swift
//  Telemed
//
//  Created by dr.mac on 07/06/19.
//  Copyright © 2019 dr.mac. All rights reserved.
//

import UIKit
@IBDesignable
class UIViewStyling: UIView {

    var borderlineColor : UIColor = .black
    var strValue : String = ""
    
    @IBInspectable var LabelText:String{
        get {
            return ""
        }
        set {
            strValue = newValue//makeALabel(Str: newValue)
        }
    }
    
    @IBInspectable var ColorOfBorderLine:UIColor{
        get {
            return .black
        }
        set {
            return borderlineColor = newValue
        }
    }
    
    override func awakeFromNib() {
        makeALabel(Str: strValue )
    }
    
    
    func makeALabel(Str : String)
    {
            var lbl = UILabel()
            lbl.text = Str
            lbl.font = UIFont(name: "Montserrat-Light", size: 10)
            lbl.sizeToFit()
            lbl.textColor = borderlineColor
        
        
            lbl.frame = CGRect(x:30, y: 0-10, width: lbl.frame.size.width , height: 15)
            self.addSubview(lbl)
             let position = CGFloat(25 + lbl.frame.size.width + 10)
            self.border(position: position)
    }
    
    func border(position: CGFloat) {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(self.frame.size.height))
        leftBorder.backgroundColor = borderlineColor.cgColor
        self.layer.addSublayer(leftBorder)
        let rightBorder = CALayer()
        rightBorder.frame = CGRect(x: CGFloat(self.frame.size.width - 1), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(self.frame.size.height))
        rightBorder.backgroundColor = borderlineColor.cgColor
        self.layer.addSublayer(rightBorder)
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: CGFloat(0.0), y: CGFloat(self.frame.size.height - 1), width: CGFloat(self.frame.size.width), height: CGFloat(1.0))
        bottomBorder.backgroundColor = borderlineColor.cgColor
        self.layer.addSublayer(bottomBorder)
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(25.0), height: CGFloat(1.0))
        topBorder.backgroundColor = borderlineColor.cgColor
        self.layer.addSublayer(topBorder)
        let width = CGFloat(self.frame.size.width - position)
        let topBorder2 = CALayer()
        topBorder2.frame = CGRect(x: position, y: CGFloat(0), width: width, height: CGFloat(1.0))
        topBorder2.backgroundColor = borderlineColor.cgColor
        self.layer.addSublayer(topBorder2)
    }
    
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.5, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.alpha = 1.0
                        }, completion: completion)  }
    
        func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
            UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.alpha = 0.0
                        }, completion: completion)
            }
   
}
