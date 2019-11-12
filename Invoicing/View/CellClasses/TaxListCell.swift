//
//  TaxListCell.swift
//  Invoicing
//
//  Created by MAC on 02/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwipeCellKit
import IoniconsKit
class TaxListCell: SwipeTableViewCell {
    @IBOutlet var lblTaxName : UILabel?
    @IBOutlet var lblTaxNumber : UILabel?
    @IBOutlet var viewShadow : UIView?

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTaxName?.font = .TitleFont()
        lblTaxNumber!.font = .SubTitleFont()
        
    }
    
   
    
    func setCellData(Taxes : TaxObject){
        
        
        print(Taxes)
        print(Taxes.name as Any)
        print(Taxes.taxNumber as Any)

        
        lblTaxName?.text = Taxes.name
        lblTaxNumber?.text = "\(Taxes.taxNumber )"
    }
    
    
}
