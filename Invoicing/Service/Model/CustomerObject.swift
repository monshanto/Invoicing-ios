//
//  CustomerObject.swift
//  Invoicing
//
//  Created by MACBOOK on 01/10/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class CustomerObject: NSObject {
    
    var customer_id: Int = 0
    var user_name: String = ""
    var email_id: String = ""
    var first_name: String = ""
     var last_name: String = ""
    var Address: String = ""
    var website: String = ""
    var mobile: String = ""
     var phone: String = ""
    
    
     var Selection: Int = 0
      var isActive: Int = 0
    
    
    
   
    
    
    init(model: [String : Any]) {
        
        
        if let customer_id = model["customerId"] as? Int{
            self.customer_id = customer_id
        }
        if let user_name = model["bussinessName"] as? String{
            self.user_name = user_name
        }
        if let email_id = model["personalEmail"] as? String{
            self.email_id = email_id
        }
        if let first_name = model["firstName"] as? String{
            self.first_name = first_name
        }
        
        if let last_name = model["lastName"] as? String{
            self.last_name = last_name
        }
        if let Address = model["address1"] as? String{
            self.Address = Address
        }
        if let website = model["website"] as? String{
            self.website = website
        }
        if let phone = model["phone"] as? String{
            self.phone = phone
        }
        if let mobile = model["mobile"] as? String{
            self.mobile = mobile
        }
    
    if let isActive = model["isActive"] as? Int{
    self.isActive = isActive
    }
        
       
       
        
        
    }
    
    

}
