
import UIKit

class LogoutAPIRequest: NSObject {
    
    static let shared = LogoutAPIRequest()
    
    func Logout(requestParams : [String:Any], completion: @escaping (_ message : String?, _ status : Bool) -> Void) {
//        AlamofireRequest.shared.postDataFor(urlString: "BaseURL".LogOutURL, parameters: requestParams, authToken: AppUser.accessToken, imageData: nil, isLoader: true, loaderMessage: "") { (data, error) in
//
             AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".LogOutURL, parameters: requestParams, authToken: AppUser.accessToken, isLoader: true, loaderMessage: "Sign in") { (data, error) in
            
            
            if error == nil{
                print(data as Any)
                
                if let status = data?["status"] as? Int{
                    
                    if status != 500{
                        
                        var messageString : String = ""
                        var status_value : Bool = false
                        var user_status : Bool = false
                        
                        if let msg = data?["message"] as? String{
                            messageString = msg
                        }
                        
                        if let status = data?["success"] as? Bool{
                            
                            status_value = status
                        }
                        
                        if let status = data?["userstatus"] as? Bool{
                            
                            user_status = status
                        }
                        
                        if user_status == true{
                            
                            if status_value == true {
                                
                                completion(messageString, true)
                            }
                            else{
                                
                                completion(messageString, false)
                                
                                
                                
                            }
                            
                        }
                        else{
                            
                            completion(messageString, true)
                            
                            
                            
                        }
                    }
                    else
                    {
                        completion( "There was an error connecting to server.", false)
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    completion( "There was an error connecting to server.", false)
                    
                    
                    
                }
                
            }else{
                completion("There was an error connecting to server.try again", false)
            }
        }
    }
}



