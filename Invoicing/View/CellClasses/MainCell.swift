//
//  MainCell.swift
//  Invoicing
//
//  Created by MAC on 29/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwipeCellKit
import IoniconsKit
class MainCell: SwipeTableViewCell {
    
    @IBOutlet weak var Title_LBL: UILabel!
    @IBOutlet weak var SubTitle_LBL: UILabel!
    @IBOutlet weak var Date_LBL: UILabel!
    @IBOutlet weak var Status_LBL: UILabel!
    @IBOutlet weak var Price_LBL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        Title_LBL.font = .TitleFont()
        SubTitle_LBL.font = .SubTitleFont()
        Date_LBL.font = .DateFont()
        Price_LBL.font = .PriceFont()
        Status_LBL.font = .StatusFont()
        Price_LBL.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
