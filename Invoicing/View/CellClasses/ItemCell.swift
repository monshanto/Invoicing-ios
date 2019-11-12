//
//  ItemCell.swift
//  Invoicing
//
//  Created by MAC on 07/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwipeCellKit
import IoniconsKit
class ItemCell: SwipeTableViewCell {
    @IBOutlet weak var Name_lbl: UILabel!
    @IBOutlet weak var Description_lbl: UILabel!
    @IBOutlet weak var Price_lbl: UILabel!
    @IBOutlet weak var Taxes_lbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        Name_lbl.font = .TitleFont()
        Description_lbl.font = .SubTitleFont()
        Price_lbl.font = .PriceFont()
        Price_lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCellData(Items : ItemObject){
        Taxes_lbl.textColor = UIColor.lightGray
        Taxes_lbl.font = .LightStatusFont()

        
        Name_lbl?.text = Items.title
        Description_lbl?.text = "\(Items.descriptions )"
        
        let TaxValue = ((Items.Price * Double(Items.quantity)) * Items.Tax) / 100.0
        let totlal = (Items.Price * Double(Items.quantity)) + Double(TaxValue)
        Price_lbl?.text = "$\(String(format: "%.2f", totlal))"
        Taxes_lbl?.text = "\(Items.Tax)%"
        
            
            
        }
        
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    func setCellData(InvoiceItems : InvoiceItems){

        
        Name_lbl?.text = InvoiceItems.title
        Description_lbl?.text = "\(InvoiceItems.descriptions )"
        Price_lbl?.text = "$\(InvoiceItems.price )"
    

    }


}
