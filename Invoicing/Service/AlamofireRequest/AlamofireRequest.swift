
import UIKit
import Alamofire

class AlamofireRequest: NSObject {
    var reachability: Reachability!
    static let shared = AlamofireRequest()
    
    
    
    
    
    func MsgAlert()
    {
        let alert = UIAlertController(title: "Internet not available, Cross check your internet connectivity and try again", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func getDataFrom(urlString : String ,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            
            Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    debugPrint(response)
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    if let responseDictionary = response.result.value{
                        completion(responseDictionary as AnyObject, nil)
                    }else{
                        completion(nil , response.error)
                    }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    
    func postDataFor(urlString : String,parameters : Parameters ,authToken : String?,imageData : Data?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            let appendedURL : String =   urlString
            

            
            var headers: HTTPHeaders!
            if authToken != nil{
                headers = [
                    "access_token": authToken!,
                    "Content-Type": "multipart/form-data; boundary=--------------------------238949213887640225727217"
                ]
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if imageData != nil{
                    multipartFormData.append(imageData!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                
            }, usingThreshold: UInt64.init(), to: appendedURL, method: .post, headers: headers) { (result) in
                debugPrint(result)
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            completion(nil , response.error)
                        }
                    }
                case .failure( let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    
    
    
    
    
    func DeleteDataFor(urlString : String,parameters : Parameters ,authToken : String?,imageData : Data?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            let appendedURL : String =   urlString
            
            var headers: HTTPHeaders!
            if authToken != nil{
                headers = [
                    "access_token": authToken!,
                    "Content-Type": "application/json"
                ]
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if imageData != nil{
                    multipartFormData.append(imageData!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                
            }, usingThreshold: UInt64.init(), to: appendedURL, method: .delete, headers: headers) { (result) in
                debugPrint(result)
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            completion(nil , response.error)
                        }
                    }
                case .failure( let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    
    
    func postBodyFor(urlString : String,parameters : Parameters ,authToken : String?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            let appendedURL : String =   urlString
            
            var headers: HTTPHeaders!
            if authToken != nil{
                
                
                
                let bearer : String = "\(authToken!)"
                
                headers = [
                    "access_token": bearer,
                    "Content-Type": "application/json"
                ]
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, usingThreshold: UInt64.init(), to: appendedURL, method: .post, headers: headers) { (result) in
                debugPrint(result)
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            
                            print(responseDictionary)
                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            
                            if isLoader{
                                Indicator.shared.stopAnimating()
                            }
                            completion(nil , response.error)
                        }
                    }
                case .failure( let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    
    
    func PostBodyForRawData(urlString : String,parameters : Parameters ,authToken : String?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
        
        
        
        let urL = URL(string: urlString)
        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
            let jsonString = String(data: data, encoding: .utf8) {
            
            var request = URLRequest(url: urL!)
            request.httpMethod = HTTPMethod.post.rawValue
            
            
            if authToken != nil{
                
                let bearer : String = "Bearer \(authToken!)"
                
                request.addValue(bearer, forHTTPHeaderField: "Authorization")
               
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonString.data(using: .utf8)
            
            Alamofire.request(request)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                            Indicator.shared.stopAnimating()
                       completion(nil , error)
                        
                    case .success( _):
                        
                        
                        if let responseDictionary = response.result.value{
                            
                            print(responseDictionary)
                            Indicator.shared.stopAnimating()

                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            
                                Indicator.shared.stopAnimating()
                            completion(nil , response.error)
                        }
                        
                        
                    }
                    
            }
            
            
        }
        else{
            Indicator.shared.stopAnimating()
        }
        
        
    }
    
    }
    
    func getBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                
                if auth != nil{
                    
                    let bearer : String = "Bearer \(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    func PostBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.post.rawValue
                
                if auth != nil{
                    
                    let bearer : String = "\(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "access_token")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    func PUTBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        
        if reachability.connection != .none {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.put.rawValue
                
                if auth != nil{
                    
                    let bearer : String = "\(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "access_token")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            
            MsgAlert()
        }
    }
    
    func DeleteBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        reachability = Reachability()!
        
        
        if reachability.connection != .none {
            
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.delete.rawValue
                
                if auth != nil{
                    
                    let bearer : String = "\(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "access_token")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
            
        else
        {
            
            MsgAlert()
        }
        
    }
    
    
    func InterNetConnection()->Bool  {
        
        reachability = Reachability()!
        
        
        if reachability.connection != .none {
            
            return true
            
        }
        else
        {
            return false
            
        }
        
    }
}



