//
//  EditProfileObject.swift
//  Invoicing
//
//  Created by MAC on 23/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ShowProfileObject: NSObject {
    
    
    var user_name: String = ""
    var email_id: String = ""
    var phone_no: String = ""
    var company_name: String = ""
    var fax: String = ""
    var web_address: String = ""
    var profile_pic: String = ""
    var user_status: Bool = false
    
   
  
    
    
    init(model: [String : Any]) {
        
        
        if let user_name = model["name"] as? String{
            self.user_name = user_name
        }
        if let email_id = model["email"] as? String{
            self.email_id = email_id
        }
        if let phone_no = model["phone_no"] as? String{
            self.phone_no = phone_no
        }
        if let company_name = model["company_name"] as? String{
            self.company_name = company_name
        }
        if let fax = model["fax"] as? String{
            self.fax = fax
        }
        if let web_address = model["web_address"] as? String{
            self.web_address =  web_address
        }
        
        if let profile_pic = model["profile_pic"] as? String{
            self.profile_pic =  profile_pic
        }
        if let user_status = model["userstatus"] as? Bool{
            self.user_status =  user_status
        }
        
    }
    
    
    
    
}

