//
//  EmptyStateView.swift
//  StateView
//
//  Created by Alberto Aznar de los Ríos on 23/05/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class NoDataFound: UITableViewCell {
    
    @IBOutlet weak var NoDataImage: UIImageView!
    
    @IBOutlet weak var NoDataTitle: UILabel!
    
    @IBOutlet weak var NoDataSubTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // NoDataTitle.font = .TitleFont()
       // NoDataSubTitle.font = .SubTitleFont()
        
    }
    
}
