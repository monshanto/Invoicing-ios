//
//  SubTotalCell.swift
//  Invoicing
//
//  Created by MAC on 08/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SubTotalCell: UITableViewCell {
    
    @IBOutlet weak var SubTotal_Title: UILabel!
    @IBOutlet weak var SubTotal_txt: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
          SubTotal_Title.font = .TitleFont()
          SubTotal_txt.font = .SubTitleFont()
        
        SubTotal_Title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
