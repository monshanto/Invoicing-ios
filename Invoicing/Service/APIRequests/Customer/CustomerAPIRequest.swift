

import UIKit

class CustomerAPIRequest: NSObject {
    
    static let shared = CustomerAPIRequest()
    
    func Customer(requestParams : [String:Any],isLoader:Bool, completion: @escaping (_ object: [CustomerObject]?,_ message : String?, _ status : Bool,_ session:Bool) -> Void) {
        
        
        AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".CustomerListURL, parameters: requestParams, authToken: AppUser.accessToken, isLoader:isLoader , loaderMessage: "Getting") { (data, error) in
        
//        AlamofireRequest.shared.postDataFor(urlString: "BaseURL".CustomerListURL, parameters: requestParams, authToken: AppUser.accessToken, imageData: nil, isLoader: isLoader, loaderMessage: "Getting") { (data, error) in
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
                                
                                if let result = data?["customerList"] as? [String : Any]{
                                    
                                    print(result)
                                    
                                    var customerObject : [CustomerObject] = []
                                    
                                    if let customerList = result["dataList"] as? NSArray{
                                        
                                        for customer in customerList{
                                            let customer : CustomerObject = CustomerObject.init(model: customer as! [String : Any])
                                            customerObject.append(customer)
                                        }
                                        
                                        completion(customerObject, messageString, true, true)
                                        
                                        
                                    }
                                    else
                                    {
                                        completion(customerObject, messageString, true, true)
                                        
                                    }
                                    
                                    
                                    
                                    print(result)
                                    
                                    
                                }else{
                                    
                                    completion(nil, messageString, true,true)
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





