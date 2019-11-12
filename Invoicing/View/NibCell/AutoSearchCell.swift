//
//  AutoSearchCell.swift
//  Invoicing
//
//  Created by MACBOOK on 14/10/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AutoSearchCell: UITableViewCell {

    @IBOutlet weak var Address_Title: UILabel!
    @IBOutlet weak var Address_SubTitle: UILabel!
    @IBOutlet weak var Search_Image: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Address_Title.font = .LightTitleFont()
        Address_SubTitle.font = .LightSmaillFont()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
