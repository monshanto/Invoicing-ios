
import UIKit

class LinkedUserAPIRequest: NSObject {
    
    static let shared = LinkedUserAPIRequest()
    
    func LinkedUser(requestParams : [String:Any],isLoader:Bool, completion: @escaping (_ object: [LinkedObject]?,_ message : String?, _ status : Bool,_ session:Bool) -> Void) {

                
                AlamofireRequest.shared.getBodyFrom(urlString: "BaseURL".LinkedUserURL, isLoader: true, param: requestParams, loaderMessage: "Getting", auth: AppUser.accessToken) { (data, error) in
            
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
                                
                               
                                    var linkedObject : [LinkedObject] = []
                                    
                                    if let linkedList = data?["linkedusers"] as? Array<Any>{
                                        
                                        for linked in linkedList{
                                            let linked : LinkedObject = LinkedObject.init(model: linked as! [String : Any])
                                            linkedObject.append(linked)
                                        }
                                        
                                        completion(linkedObject, messageString, true, true)
                                        
                                        
                                    }
                                    else
                                    {
                                        completion(linkedObject, messageString, false, true)
                                        
                                    }
                                
                               
                            }
                            else{
                                
                                completion(nil,messageString, false,true)
                                
                                
                                
                            }
                            
                        }
                        else{
                            
                            completion(nil,messageString, false,false)
                            
                            
                            
                        }
                    }
                    else
                    {
                        completion(nil,"There was an error connecting to server.", false,true)
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    completion(nil, "There was an error connecting to server.", false,true)
                    
                    
                    
                }
                
            }else{
                completion(nil,"There was an error connecting to server.try again", false,true)
            }
        }
    }
}






