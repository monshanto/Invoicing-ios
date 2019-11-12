//
//  DashboardTvc.swift
//  Invoicing
//
//  Created by apple on 08/07/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DashboardTvc: UITableViewCell {
    
    @IBOutlet weak var TopView: UIView!
     @IBOutlet weak var LblHello: UILabel!
    @IBOutlet weak var LblUserName: UILabel!
    @IBOutlet weak var BTNCreateInvoice: UIButton!
    @IBOutlet weak var LblTopTitle: UILabel!
    @IBOutlet weak var LblLastweekIncome: UILabel!
    @IBOutlet weak var LblLastMonthIncome: UILabel!
    @IBOutlet weak var LblSecondMonthIncome: UILabel!
    @IBOutlet weak var LblYearIncome: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        BTNCreateInvoice.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1), for: .normal)
        LblHello.textColor = UIColor.white
        LblUserName.textColor = UIColor.white
        LblTopTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblLastweekIncome.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblLastMonthIncome.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblSecondMonthIncome.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        LblYearIncome.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
