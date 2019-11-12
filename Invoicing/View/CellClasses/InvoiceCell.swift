//
//  InvoiceCell.swift
//  Invoicing
//
//  Created by MAC on 07/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class InvoiceCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var Invoice_Title: UILabel!
    @IBOutlet weak var Invoice_txt: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()

        Invoice_txt.delegate = self
        Invoice_Title.font = .LightTitleFont()
        Invoice_txt.font = .LightStatusFont()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
    

}
