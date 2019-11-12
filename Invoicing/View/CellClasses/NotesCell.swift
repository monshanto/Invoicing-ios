//
//  NotesCell.swift
//  Invoicing
//
//  Created by MAC on 09/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var Notes_tvt: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        Notes_tvt.delegate = self
        Notes_tvt.showsVerticalScrollIndicator = false
        Notes_tvt.showsHorizontalScrollIndicator = false
        Notes_tvt.font = .SubTitleFont()
        
        // Initialization code
    }

//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == "Description" {
//            textView.text = ""
//            textView.textColor = UIColor.black
//        }
//    }
//    
//    
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text == "" {
//            textView.text = "Description"
//            textView.textColor = UIColor.lightGray
//        }
//    }

}
