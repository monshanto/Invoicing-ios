
import UIKit
import SwipeCellKit
import IoniconsKit
class TeamCell: SwipeTableViewCell {

     @IBOutlet var viewShadow : UIView?
    var gender : String = "Male_PH"
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblemailid: UILabel!
    
    
    var CurrentTax : LinkedObject?
    var Customer : CustomerObject?


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblUserName.font = .StatusFont()
        lblemailid.font = .RegularStatusFont()
      
    }
    
    func setCellData(LinkedUser : LinkedObject){
        
        imgUser?.setImage(string:LinkedUser.user_name, color: nil, circular: true)
        lblUserName.text = LinkedUser.user_name
        lblemailid.text = LinkedUser.email_id
        
        
        
       
    }
    
    func setCellData(Customer : CustomerObject){
        
        imgUser?.setImage(string:"\(Customer.first_name)  \(Customer.last_name)", color: nil, circular: true)
        lblUserName.text = "\(Customer.first_name)  \(Customer.last_name)"
        lblemailid.text = Customer.email_id
        
        
        
        
    }
    func setCellData(Customer : InvoiceCustomer){
        
        imgUser?.setImage(string:"\(Customer.first_name)  \(Customer.last_name)", color: nil, circular: true)
        lblUserName.text = "\(Customer.first_name)  \(Customer.last_name)"
        lblemailid.text = Customer.email_id
        
        
        
        
    }
    
    
    
    
    
}
