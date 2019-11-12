

import Foundation

class LinkedObject : NSObject {
    
    
    var user_name: String = ""
    var email_id: String = ""
    var user_id: String = ""
    
    
    init(model: [String : Any]) {
        
        if let user_name = model["name"] as? String{
            self.user_name = user_name
        }
        if let email_id = model["email"] as? String{
            self.email_id = email_id
        }
        if let user_id = model["id"] as? String{
            self.user_id = user_id
        }
       
        
    }
    
    
    
    
}


