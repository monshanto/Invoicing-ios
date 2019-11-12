//
//  DashboardSecondTvc.swift
//  Invoicing
//
//  Created by apple on 08/07/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DashboardSecondTvc: UITableViewCell {
    
    @IBOutlet weak var BottomView: UIView!
    
    @IBOutlet weak var LblinvoiceCount: UILabel!
    @IBOutlet weak var LblquationCount: UILabel!
    @IBOutlet weak var LblexpenceCount: UILabel!
    @IBOutlet weak var LblcustomerCount: UILabel!
    
    
    @IBOutlet weak var LblinvoiceTitle: UILabel!
    @IBOutlet weak var LblquationTitle: UILabel!
    @IBOutlet weak var LblexpenceTitle: UILabel!
    @IBOutlet weak var LblcustomerTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        LblinvoiceCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblquationCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblexpenceCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblcustomerCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        
        LblinvoiceTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblquationTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblexpenceTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblcustomerTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
