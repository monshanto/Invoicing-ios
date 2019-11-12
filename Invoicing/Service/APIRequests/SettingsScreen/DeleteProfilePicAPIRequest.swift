
import UIKit

class DeleteProfilePicAPIRequest: NSObject {
    
    static let shared = DeleteProfilePicAPIRequest()
    
    func DeleteProfilePic(requestParams : [String:Any], completion: @escaping (_ message : String?, _ status : Bool,_ session:Bool) -> Void) {
        AlamofireRequest.shared.postDataFor(urlString: "BaseURL".DeleteProfilePicURL, parameters: requestParams, authToken: AppUser.accessToken, imageData: nil, isLoader: true, loaderMessage: "") { (data, error) in
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
                            
                            if status_value == true &&  user_status == true{
                                
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





