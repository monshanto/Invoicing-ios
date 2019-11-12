//
//  AddClientCell.swift
//  Invoicing
//
//  Created by MAC on 06/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AddClientCell: UITableViewCell {
    
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var AddCustomerText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        imageVw.image = UIImage.ionicon(with: .androidAddCircle, textColor: UIColor.black, size: CGSize(width: 18, height: 18))

        AddCustomerText.font = .TitleFont()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
