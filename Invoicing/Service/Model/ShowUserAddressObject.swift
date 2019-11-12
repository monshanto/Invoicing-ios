//
//  EditProfileObject.swift
//  Invoicing
//
//  Created by MAC on 23/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ShowUserAddressObject: NSObject {
    
    
    var address1: String = ""
    var address2: String = ""
    var phone_no: String = ""
    var country_name: String = ""
    var state_name: String = ""
    
    var countryId: Int = 0
    var stateId: Int = 0
    
    var city: String = ""
    var postalcode: String = ""
    var user_status: Bool = false
    
    
  
    
    init(model: [String : Any]) {
        
        
        if let address1 = model["address1"] as? String{
            self.address1 = address1
        }
        if let address2 = model["address2"] as? String{
            self.address2 = address2
        }
        if let phone_no = model["phone_no"] as? String{
            self.phone_no = phone_no
        }
        if let country_name = model["countryName"] as? String{
            self.country_name = country_name
        }
        if let state_name = model["stateName"] as? String{
            self.state_name = state_name
        }
        
        if let countryId = model["countryId"] as? Int{
            self.countryId = countryId
        }
        if let stateId = model["stateId"] as? Int{
            self.stateId = stateId
        }
        
        
        if let city = model["city"] as? String{
            self.city =  city
        }
        
        if let postalcode = model["postalcode"] as? String{
            self.postalcode =  postalcode
        }
        
        if let user_status = model["userstatus"] as? Bool{
            self.user_status =  user_status
        }
        
    }
    
    
    
    
}



