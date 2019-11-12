//
//  DashboardVc.swift
//  Invoicing
//
//  Created by apple on 08/07/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Crashlytics
import IoniconsKit
import EmptyStateKit
import Alamofire

class DashboardVc: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var TopView: UIView!
    private let refreshControl = UIRefreshControl()

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Class life cycle

    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.navigationController?.navigationBar.topItem?.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
      //  self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableVw.refreshControl = refreshControl
        } else {
            tableVw.addSubview(refreshControl)
        }
        
    }
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        
        //  InterNet Check
        if AlamofireRequest.shared.InterNetConnection()
        {
            tableVw.reloadData()
            refreshControl.endRefreshing()
        }
        else
        {
            refreshControl.endRefreshing()
            // Check InterNet Connection
            CheckInterNetConnection()
        }
        
        
        
    }

    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.separatorStyle = .none
        tableVw.alwaysBounceVertical = false
        tableVw.alwaysBounceHorizontal = false


        tableVw.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        TopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)

        
//        let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//        btSlider.tintColor = UIColor.white
//        navigationItem.leftBarButtonItem = btSlider
        
        
        
        let btNotification = UIBarButtonItem(image: UIImage.ionicon(with: .androidNotifications, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenbtNotification))
               btNotification.tintColor = UIColor.white
               navigationItem.rightBarButtonItem = btNotification
        
        
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
    }
    
    
   
    
    // MARK: - OpenbtNotification
       @objc func OpenbtNotification(){
        
          let storyboard = UIStoryboard(name: "Home", bundle: nil)
           let Switchobj = storyboard.instantiateViewController(withIdentifier: "Notifications") as? Notifications
        self.navigationController?.pushViewController(Switchobj!, animated: true)
           
       }
    
    
    
    @IBAction func btnCreateInvoiceAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateInvoice") as! CreateInvoice
            vc.ClassType = "Invoice"
            vc.Title = "New Invoice"
        vc.tabBarController?.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
   
    @IBAction func btnInvoiceAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InvoicesVc") as! InvoicesVc
        vc.BackButtonStatus = true
       self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func btnQuotationAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Quotations") as! Quotations
        vc.BackButtonStatus = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnExpensesAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Billing") as! Billing
        vc.BackButtonStatus = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCustomerAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddContact") as! AddContact
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    @IBAction func btnMenuAction(_ sender: Any) {

        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
    }

}


// MARK: - Table View Delegate/DataSource Methods

extension DashboardVc: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableVw.dequeueReusableCell(withIdentifier: "cell") as! DashboardTvc
            cell.selectionStyle = .none
            cell.LblUserName.text =  AppUser.name


            return cell
        }
        else{
            let cell = tableVw.dequeueReusableCell(withIdentifier: "secondCell") as! DashboardSecondTvc
            cell.selectionStyle = .none

            return cell
        }
    
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 500
        }else{
            return 410
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableVw.deselectRow(at: indexPath, animated: true)
        
    }
    
    

}


extension DashboardVc: EmptyStateDelegate {
    
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
