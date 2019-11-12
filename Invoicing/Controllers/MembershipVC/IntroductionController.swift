//
//  IntroductionController.swift
//  HealthEngineDoc
//
//  Created by dr.mac on 21/08/19.
//  Copyright © 2019 dr.mac. All rights reserved.
//

import UIKit
import EmptyStateKit
import Alamofire

class IntroductionController: UIViewController {

    @IBOutlet fileprivate var Collectionview : UICollectionView!
    @IBOutlet fileprivate var pageController : UIPageControl!
   

    var currentIndex = Int()
    
    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "MemberShip"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
//        let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//        btSlider.tintColor = UIColor.white
//        navigationItem.leftBarButtonItem = btSlider
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentIndex = 0
        setupPageController()
        
        
      
        // Call Setup Navigation setting Function
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check InterNet Connection
        CheckInterNetConnection()

    }
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
    }
    
    fileprivate func setupPageController()
    {
        pageController.numberOfPages = 3
    }
    
    
    @IBAction fileprivate func NextAction (_ sender : UIButton)
    {
        
        let nextItem: IndexPath = IndexPath(item: currentIndex + 1, section: 0)
        self.Collectionview.scrollToItem(at: nextItem, at: .right, animated: true)

    }
  

}

extension IntroductionController : UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembershipCell", for: indexPath) as? MembershipCell
            
            return cell ?? UICollectionViewCell()
        }
        else if (indexPath.row == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCell1", for: indexPath) as? IntroductionCell1
            
            return cell ?? UICollectionViewCell()
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCell2", for: indexPath) as? IntroductionCell2
            
            return cell ?? UICollectionViewCell()
        }
    
        
        
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 144
        
        return CGSize(width: screenWidth, height: screenHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = self.Collectionview!.indexPathForItem(at: center) {
            self.pageController.currentPage = ip.row
            currentIndex = ip.row
            if ip.row == 3{
                

            }
            else{
              

            }
        }
    }
  
    
    
    
}

extension IntroductionController: EmptyStateDelegate {
    
    func emptyState(emptyState: EmptyState, didPressButton button: UIButton) {
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
    }
    
    // MARK: - Check InterNet Connection
    func CheckInterNetConnection()
    {
        if !AlamofireRequest.shared.InterNetConnection()
        {
            view.emptyState.delegate = self
            view.emptyState.show(TableState.noInternet)
            
        }
        else
        {
            view.emptyState.hide()
            
        }
        
    }
    
}


