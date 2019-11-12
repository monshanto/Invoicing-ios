
import UIKit

class ResendEmailAPIRequest: NSObject {
    
    static let shared = ResendEmailAPIRequest()
    
    func ResendEmail(requestParams : [String:Any], completion: @escaping (_ message : String?, _ status : Bool,_ session : Bool) -> Void) {
        
        AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".ResendEmailURL, parameters: requestParams, authToken: "", isLoader: true, loaderMessage: "") { (data, error) in
            
            if error == nil{
                print(data as Any)
                
                if let status = data?["status"] as? Int{
                    
                    if status != 500{
                        
                        var messageString : String = ""
                        var status_value : Bool = false
                        var userstatus : Bool = false
                        
                        if let msg = data?["message"] as? String{
                            messageString = msg
                        }
                        
                        if let status = data?["success"] as? Bool{
                            
                            status_value = status
                        }
                        
                        if let StatusUser = data?["userstatus"] as? Bool{
                            userstatus = StatusUser
                        }
                        
                        if userstatus == true{
                            
                            if status_value == true{
                                
                                completion(messageString, true,true)
                            }
                            else{
                                
                                completion(messageString, false,true)
                                
                                
                                
                            }
                            
                        }
                        else{
                            
                            completion(messageString, false,false)
                            
                            
                            
                        }
                    }
                    else
                    {
                        completion( "There was an error connecting to server.", false,true)
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    completion( "There was an error connecting to server.", false,true)
                    
                    
                    
                }
                
            }else{
                completion("There was an error connecting to server.try again", false,true)
            }
        }
    }
}



