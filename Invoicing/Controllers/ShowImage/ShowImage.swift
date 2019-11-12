//
//  ShowImage.swift
//  MedMobilie
//
//  Created by MAC on 01/02/19.
//  Copyright © 2019 dr.mac. All rights reserved.
//

import UIKit

class ShowImage: UIViewController,UIScrollViewDelegate {
    
    var img_Var : UIImage?

    @IBOutlet fileprivate var Attachment_Img: UIImageView!
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Attachment"
        
        
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        
        let scrollImg: UIScrollView = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x:0, y: 0, width:vWidth, height:vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        self.view!.addSubview(scrollImg)
        
        Attachment_Img.layer.cornerRadius = 11.0
        Attachment_Img.clipsToBounds = false
        scrollImg.addSubview(Attachment_Img)

        
        if let img = img_Var
        {
            Attachment_Img.image = img
            Attachment_Img.contentMode = .scaleAspectFit
        }
        else
        {
            
            let alert = UIAlertController(title: "", message: "Image not found",         preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                
             self.navigationController?.popViewController(animated: true)

            }))
            
            self.present(alert, animated: true, completion: nil)
            
           
        }
        
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.Attachment_Img
    }
   
}
// MARK: - Class Instance

extension ShowImage
{
    class func instance()->ShowImage?{
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ShowImage") as? ShowImage
        
        return controller
    }
}
