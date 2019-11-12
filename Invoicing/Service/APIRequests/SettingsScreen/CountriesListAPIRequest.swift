
import UIKit

class CountriesListAPIRequest: NSObject {
    
    static let shared = CountriesListAPIRequest()
    
    func CountriesList(requestParams : [String:Any], completion: @escaping (_ message : String?, _ status : Bool,_ session:Bool,_ Data:[String : Any]) -> Void) {
        
      
        AlamofireRequest.shared.getBodyFrom(urlString: "BaseURL".GetCountryListURL, isLoader: true, param: requestParams, loaderMessage: "Getting", auth: AppUser.accessToken) { (data, error) in
            
            
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
                        
                            if status_value == true{
                                
                                completion( messageString, false,true,data as! [String : Any])
                                
                            }else{
                                
                                completion( messageString, false,true,[:])
                                
                            }
                    }
                    else
                    {
                        
                        completion( "There was an error connecting to server.", false,true,[:])
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    completion( "There was an error connecting to server.", false,true,[:])
                    
                    
                }
                
            }
            else{
                completion( "There was an error connecting to server.try again", false,true,[:])
            }
            
            
        }
        
        
        
        
        
    }
    
}




