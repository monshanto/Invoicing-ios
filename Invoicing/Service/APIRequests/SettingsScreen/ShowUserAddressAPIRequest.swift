
import UIKit

class ShowUserAddressAPIRequest: NSObject {
    
    static let shared = ShowUserAddressAPIRequest()
    
    func ShowUserAddress(requestParams : [String:Any], completion: @escaping (_ object: ShowUserAddressObject?,_ message : String?, _ status : Bool,_ session:Bool) -> Void) {
        
//        AlamofireRequest.shared.postBodyFor(urlString: "BaseURL".ShowAddressURL, parameters: requestParams, authToken:AppUser.accessToken, isLoader: true, loaderMessage: "Getting") { (data, error) in
//
//            AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".ShowAddressURL, parameters: requestParams, authToken: AppUser.accessToken, isLoader: true, loaderMessage: "Getting") { (data, error) in
        
               AlamofireRequest.shared.getBodyFrom(urlString: "BaseURL".ShowAddressURL, isLoader: true, param: requestParams, loaderMessage: "Getting", auth: AppUser.accessToken) { (data, error) in
            
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
                            
                            
                            if status_value == true{
                                
                               // if let result = data?["data"] as? [String : Any]{
                                    
                                    if let result = data?["user_info"] as? [String : Any]{
                                        
                                        print(result)
                                        
                                        
                                        let userModel : ShowUserAddressObject = ShowUserAddressObject.init(model: result)
                                        
                                        completion(userModel, nil, true,true)
                                        
                                    }
                                    else
                                    {
                                        completion(nil, messageString, false,true)
                                        
                                    }
                                    
//                                    print(result)
//
//
//                                }else{
//
//                                    completion(nil, messageString, false,true)
//                                }
                            }else{
                                
                                
                                completion(nil, messageString, false,true)
                                
                                
                            }
                        }
                            
                        else{
                            
                            completion(nil,messageString, false,false)
                            
                            
                            
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
                completion(nil, "There was an error connecting to server.try again", false,true)
            }
            
            
        }
        
        
        
        
        
    }
    
}




