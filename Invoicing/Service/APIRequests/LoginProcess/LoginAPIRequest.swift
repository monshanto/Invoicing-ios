
import UIKit

class LoginAPIRequest: NSObject {
    
    static let shared = LoginAPIRequest()
    
    func login(requestParams : [String:Any], completion: @escaping (_ object: LoginObject?,_ message : String?, _ status : Bool,_ Verification : Bool) -> Void) {
        
        AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".LoginURL, parameters: requestParams, authToken: "", isLoader: true, loaderMessage: "Sign in") { (data, error) in
            if error == nil{
                print(data as Any)
                
                if let status = data?["status"] as? Int{
                    
                      if status != 500  {
                    
                    var messageString : String = ""
                    var status_value : Bool = false
                    var userstatus : Bool = false
                    if let msg = data?["message"] as? String{
                        messageString = msg
                    }
                        
                        
                        if let userstatu = data?["userstatus"] as? Bool{
                            userstatus = userstatu
                        }
                        
                    if let status = data?["success"] as? Bool{
                            
                            status_value = status
                        }
                        
                      if   userstatus == true
                      {
                        
                        
                        
                    if status_value == true{
                        
                        if let result = data!["user_info"] as? [String : Any]{
                                
                                print(result)
                                
                                
                                let userModel : LoginObject = LoginObject.init(model: result)
                                
                                completion(userModel, nil, true,true)
                                
                            }
                            else
                            {
                                completion(nil, messageString, false,true)
                                
                            }
                       }
           
                      else{
                        
                        completion(nil, messageString, false,false)
                        
                    }
                        
                    }
                      else{
                        
                        completion(nil, messageString, false,true)
                        
                    }
                }
                  else
                      {
                        
                         completion(nil, "There was an error connecting to server.", false,true)

                    }
                    
                    
            }
                else
                {
                    
                    completion(nil, "There was an error connecting to server.", false,true)
                    
                    
                }
                
            }
                else{
                completion(nil,"There was an error connecting to server.try again", false,true)
            }
        
            
    }
    
    
    
    

}

}

