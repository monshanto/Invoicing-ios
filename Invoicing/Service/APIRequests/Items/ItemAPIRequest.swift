
import UIKit

class ItemAPIRequest: NSObject {
    
    static let shared = ItemAPIRequest()
    
    func Item(requestParams : [String:Any],isLoader:Bool, completion: @escaping (_ object: [ItemObject]?,_ message : String?, _ status : Bool,_ session:Bool) -> Void) {
   
        
//        AlamofireRequest.shared.postDataFor(urlString: "BaseURL".ItemListURL, parameters: requestParams, authToken: AppUser.accessToken, imageData: nil, isLoader: isLoader, loaderMessage: "Getting") { (data, error) in
        
             AlamofireRequest.shared.PostBodyForRawData(urlString: "BaseURL".ItemListURL, parameters: requestParams, authToken: AppUser.accessToken, isLoader:isLoader , loaderMessage: "Getting") { (data, error) in
            
            
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
                                
                                  if let result = data?["itemList"] as? [String : Any]{
                                    
                                    print(result)
                                    
                                    var itemObject : [ItemObject] = []
                                    
                                    if let itemList = result["dataList"] as? NSArray{
                                        
                                        for item in itemList{
                                            let items : ItemObject = ItemObject.init(model: item as! [String : Any])
                                            itemObject.append(items)
                                        }
                                        
                                        completion(itemObject, messageString, true, true)
                                        
                                        
                                    }
                                    else
                                    {
                                        completion(itemObject, messageString, false, true)
                                        
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






