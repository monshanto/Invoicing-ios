//
//  TabBarController.swift
//  Invoicing
//
//  Created by MACBOOK on 21/10/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillAppear(true)
        
        
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let DashboardObj : DashboardVc = storyboard.instantiateViewController(withIdentifier: "DashboardVc") as! DashboardVc
//
//
//    //    let DashboardNav = UINavigationController(rootViewController: DashboardObj)
//
//        //Add navigation bar colour
//    //    DashboardNav.navigationBar.barTintColor = UIColor(red: 2/255, green: 96/255, blue: 130/255, alpha: 1.0)
//     //   DashboardNav.navigationBar.tintColor = UIColor.white
//
//        let DashboardItem = UITabBarItem(title: "Home".capitalized, image: UIImage.ionicon(with: .androidHome, textColor: UIColor.red, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.ionicon(with: .androidHome, textColor: UIColor.blue, size: CGSize(width: 30, height: 30)))
//
//        DashboardObj.tabBarItem = DashboardItem
//
//
//        // Create Tab two
//        let BillingObj : Billing = storyboard.instantiateViewController(withIdentifier: "Billing") as! Billing
//      //  let BillingNav = UINavigationController(rootViewController: BillingObj)
//
//        let BillingItem = UITabBarItem(title: "Expence".capitalized, image: UIImage.ionicon(with: .androidSend, textColor: UIColor.red, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.ionicon(with: .androidSend, textColor: UIColor.blue, size: CGSize(width: 30, height: 30)))
//        BillingObj.tabBarItem = BillingItem
//
//
//        // Create Tab three
//
//        let InvoicesObj : InvoicesVc = storyboard.instantiateViewController(withIdentifier: "InvoicesVc") as! InvoicesVc
//
//     //   let InvoicesNav = UINavigationController(rootViewController: InvoicesObj)
//
//        let InvoicesItem = UITabBarItem(title: "Income".capitalized, image: UIImage.ionicon(with: .socialUsd, textColor: UIColor.red, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.ionicon(with: .socialUsd, textColor: UIColor.blue, size: CGSize(width: 30, height: 30)))
//        InvoicesObj.tabBarItem = InvoicesItem
//
//
//
//        // Create Tab four
//
//        let DebtCollectionObj : DebtCollection = storyboard.instantiateViewController(withIdentifier: "DebtCollection") as! DebtCollection
//
//      //  let DebtCollectionNav = UINavigationController(rootViewController: DebtCollectionObj)
//
//        let DebtCollectionItem = UITabBarItem(title: "Debt".capitalized, image: UIImage.ionicon(with: .iosBox, textColor: UIColor.red, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.ionicon(with: .iosBox, textColor: UIColor.blue, size: CGSize(width: 30, height: 30)))
//        DebtCollectionObj.tabBarItem = DebtCollectionItem
//
//        // Create Tab four
//
//        let SettingObj : SettingVC = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
//
//    //    let SettingNav = UINavigationController(rootViewController: SettingObj)
//
//        let SettingItem = UITabBarItem(title: "Settings".capitalized, image: UIImage.ionicon(with: .androidSettings, textColor: UIColor.red, size: CGSize(width: 30, height: 30)), selectedImage: UIImage.ionicon(with: .androidSettings, textColor: UIColor.blue, size: CGSize(width: 30, height: 30)))
//        SettingObj.tabBarItem = SettingItem

     //   self.viewControllers = [DashboardObj,BillingObj,InvoicesObj,DebtCollectionObj,SettingObj]
    }
    
    
    
}
