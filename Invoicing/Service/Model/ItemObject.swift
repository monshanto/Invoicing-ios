
import UIKit

class ItemObject: NSObject {
    var title: String = ""
    var quantity: Int =  0
    var id: Int = 0
    var Price: Double =  0.0
    var Tax: Double =  0.0
    var descriptions: String = ""
    var Selected: Int =  0


    init(model: [String : Any]) {
        
        
        if let title = model["name"] as? String{
            self.title = title
        }
        if let id = model["itemId"] as? Int{
            self.id = id
        }
        if let description = model["description"] as? String{
            self.descriptions = description
        }
       
        if let quantity = model["quantity"] as? Int{
            self.quantity = quantity
        }
        if let Price = model["price"] as? Double{
            self.Price = Price
        }
        
        if let Tax = model["tax"] as? Double{
            self.Tax = Tax
        }
        
       
       

    }
    
   
}
    
    
    


