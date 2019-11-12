
import UIKit

class SignupAPIRequest: NSObject {
    
    static let shared = SignupAPIRequest()
    
    func Signup(requestParams : [String:Any], completion: @escaping (_ object: LoginObject?,_ message : String?, _ status : Bool) -> Void) {
       
               AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".RegisterURL, parameters: requestParams, authToken: "", isLoader: true, loaderMessage: "Sign up") { (data, error) in
            
            if error == nil{
                print(data as Any)
                
                if let status = data?["status"] as? Int{
                    
                    if status != 500{
                        
                        var messageString : String = ""
                        var status_value : Bool = false
                        if let msg = data?["message"] as? String{
                            messageString = msg
                        }
                        
                        if let status = data?["success"] as? Bool{
                            
                            status_value = status
                        }
                        
                        
                        
                        if status_value == true{
                            
//                            if let result = data?["data"] as? [String : Any]{
//
//                                if let result = result["user_info"] as? [String : Any]{
//                                    print(result)
////
////                                    let userModel : LoginObject = LoginObject.init(model: result)
 //                                   completion(nil, nil, true)
//
//                                }
//                                else
//                                {
//                                    completion(nil, messageString, false)
//
//                                }
//
//                                print(result)
//
//
//                            }else{
//
//                                completion(nil, messageString, false)
//                            }
                            
                            
                             completion(nil, nil, true)
                            
                            
                        }else{
                            
                            
                            completion(nil, messageString, false)
                            
                            
                        }
                    }
                    else
                    {
                        
                        completion(nil, "There was an error connecting to server.", false)
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    completion(nil, "There was an error connecting to server.", false)
                    
                    
                }
                
            }
            else{
                completion(nil, "There was an error connecting to server.try again", false)
            }
            
            
        }
        
        
        
        
        
    }
    
}


