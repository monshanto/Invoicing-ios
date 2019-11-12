//
//  ExtendedController.swift
//  Invoicing
//
//  Created by MACBOOK on 22/10/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ExtendedController: UIViewController {
    
    
    func paintNavigationTitle(title : String,Color : UIColor? = .white){
        
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = .SubTitleFont()
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.text = title
        label.sizeToFit()
        self.navigationItem.titleView = label
    }
    
  
}
