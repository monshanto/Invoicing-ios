

import UIKit

class InvoiceObject: NSObject {
    
     var invoice_number: String = ""
     var po_number: String = ""
     var invoice_date: String = ""
     var due_date: String = ""
     var currency: String = ""
     var descriptions: String = ""
     var total_price: String = ""
     var customer_name: String = ""
     var customer_id: String = ""
     var type: String = ""
     var status: String = ""


    
    init(model: [String : Any]) {
        
        
        if let invoice_number = model["invoice_number"] as? String{
            self.invoice_number = invoice_number
        }
        
        if let po_number = model["po_number"] as? String{
            self.po_number = po_number
        }
        if let invoice_date = model["invoice_date"] as? String{
            self.invoice_date = invoice_date
        }
        if let due_date = model["due_date"] as? String{
            self.due_date = due_date
        }
        if let currency = model["currency"] as? String{
            self.currency = currency
        }
               if let description = model["description"] as? String{
            self.descriptions = description
        }
        if let total_price = model["total_price"] as? String{
            self.total_price = total_price
        }
        if let customer_name = model["customer_name"] as? String{
            self.customer_name = customer_name
        }
        if let customer_id = model["customer_id"] as? String{
            self.customer_id = customer_id
        }
        if let type = model["type"] as? String{
            self.type = type
        }
        if let status = model["status"] as? String{
            self.status = status
        }
        
    }
    
    
    
    
    
    
}

class InvoiceCustomer: NSObject {
    var customer_id: String = ""
    var user_name: String = ""
    var email_id: String = ""
    var first_name: String = ""
    var last_name: String = ""
    
    init(model: [String : Any]) {
        
        
        
        
        if let customer_id = model["customer_id"] as? String{
            self.customer_id = customer_id
        }
        if let user_name = model["user_name"] as? String{
            self.user_name = user_name
        }
        if let email_id = model["email_id"] as? String{
            self.email_id = email_id
        }
        if let first_name = model["first_name"] as? String{
            self.first_name = first_name
        }
        
        if let last_name = model["last_name"] as? String{
            self.last_name = last_name
        }
        
        
    }
    
}

class InvoiceItems: NSObject {
    var title: String = ""
    var quantity: Int =  0
    var id: Int =  0
    var price: Double =  0.0
     var tax: Double =  0.0
    var descriptions: String = ""
    var Selected: Int =  0

    
    init(model: [String : Any]) {
        
        
        if let title = model["title"] as? String{
            self.title = title
        }
        if let id = model["_id"] as? Int{
            self.id = id
        }
        if let description = model["description"] as? String{
            self.descriptions = description
        }
        
        if let quantity = model["quantity"] as? Int{
            self.quantity = quantity
        }
        if let price = model["price"] as? Double{
            self.price = price
        }
        
        if let tax = model["tax"] as? Double{
            self.tax = tax
        }
        
        
        
        
     
        
        
        
    }
    
}
