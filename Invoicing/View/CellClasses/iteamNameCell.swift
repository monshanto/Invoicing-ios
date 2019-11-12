//
//  iteamNameCell.swift
//  Invoicing
//
//  Created by MAC on 09/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class iteamNameCell: UITableViewCell {
    @IBOutlet weak var ItemName: UITextField!{
        didSet{
            ItemName.font = .SubTitleFont()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        

        
        
        //UIFont.systemFont(ofSize: 18, weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
