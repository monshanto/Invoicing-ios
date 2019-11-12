

import Foundation

class TaxObject : NSObject {
    
    
    var taxRate: Double = 0.00
    var taxNumber: String = ""
    var name: String = ""
    var id: String = ""
    
    
    init(model: [String : Any]) {
        
        
        if let taxRate = model["tax_rate"] as? Double{
            self.taxRate = taxRate
        }
        if let taxNumber = model["tax_number"] as? String{
            self.taxNumber = taxNumber
        }
        if let name = model["name"] as? String{
            self.name = name
        }
        if let id = model["_id"] as? String{
            self.id = id
        }
        
        print(self.taxNumber as Any)
     
    }
    
    
   
   
}

