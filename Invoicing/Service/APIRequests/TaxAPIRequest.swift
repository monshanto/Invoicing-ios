
import UIKit

class TaxAPIRequest: NSObject {
    
    static let shared = TaxAPIRequest()
    
    func Tax(requestParams : [String:Any],isLoader:Bool, completion: @escaping (_ object: [TaxObject]?,_ message : String?, _ status : Bool,_ session:Bool) -> Void) {
        AlamofireRequest.shared.postDataFor(urlString: "BaseURL".TaxListURL, parameters: requestParams, authToken: AppUser.accessToken, imageData: nil, isLoader: isLoader, loaderMessage: "Getting") { (data, error) in
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
                                
                                if let result = data?["data"] as? [String : Any]{
                                    
                                        print(result)
                                        
                                        var taxObject : [TaxObject] = []
                                        
                                    if let taxList = result["taxes"] as? NSArray{
                                            
                                            for tax in taxList{
                                                let tax : TaxObject = TaxObject.init(model: tax as! [String : Any])
                                                taxObject.append(tax)
                                            }
                                            
                                            completion(taxObject, messageString, true, true)

                                            
                                        }
                                    else
                                        {
                                            completion(taxObject, messageString, false, true)

                                    }
                                    

                                    
                                    print(result)
                                    
                                    
                                }else{
                                    
                                    completion(nil, messageString, false,true)
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





