
import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var swSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
          lblTitle.font = .SubTitleFont()
    }
}
