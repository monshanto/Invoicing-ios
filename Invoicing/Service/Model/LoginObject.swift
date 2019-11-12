

import Foundation

class LoginObject : NSObject, NSCoding {

    
    var accessToken: String?
    var currency: String?
    var email: String?
    var name: String?
    var permissionsListing: Any?
    var userType: String?
    var userImage : String?
    var status : Bool?

    
    
    init(model: [String : Any]) {
        
        if let currency = model["currency"] as? String{
            self.currency = currency
        }
        if let access_token = model["accessToken"] as? String{
            self.accessToken = access_token
        }
        if let email = model["email"] as? String{
            self.email = email
        }
        if let name = model["name"] as? String{
            self.name = name
        }
        if let user_type = model["userType"] as? String{
            self.userType = user_type
        }
        
        if let status = model["status"] as? Bool{
            self.status = status
        }
        
        if let profile_pic = model["profilePic"] as? String{
            self.userImage = profile_pic
        }
        else
        {
            self.userImage = ""
            
        }
        
       
        
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        var mutDict : [String : Any] = [:]
        
      if  let token = aDecoder.decodeObject(forKey:"accessToken")
       {
        mutDict["accessToken"] = token
        }
        
         if  let currency = aDecoder.decodeObject(forKey:"currency")
         {
            mutDict["currency"] = currency
        }
        
         if  let email = aDecoder.decodeObject(forKey:"email")
         {
            mutDict["email"] = email
        }
        
         if  let name = aDecoder.decodeObject(forKey:"name")
         {
            mutDict["name"] = name
        }
        
        
        if let usertype = aDecoder.decodeObject(forKey:"userType")
        {
             mutDict["userType"] = usertype
        }
        
        if let status = aDecoder.decodeObject(forKey:"status")
        {
            mutDict["status"]  = status
        }
        
        
         if  let profile_pic = aDecoder.decodeObject(forKey:"profilePic")
         {
            mutDict["profilePic"] = profile_pic
        }
        else
         {
            mutDict["profilePic"] = ""
        }
        
        
        self.init(model: mutDict)

        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(currency, forKey: "currency")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(userImage, forKey: "profilePic")
        aCoder.encode(userType, forKey: "userType")
         aCoder.encode(status, forKey: "status")
         }
    
    func saveDetails(user : LoginObject){
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "Login")
        userDefaults.synchronize()
    }
}
