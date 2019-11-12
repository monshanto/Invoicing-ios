

import UIKit
import SwipeCellKit
import EmptyStateKit
import Alamofire


class InvoicesVc: UIViewController,UISearchResultsUpdating {
    
    
    
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    var BackButtonStatus : Bool = false
    var CreateButton : Bool = true

    var FilterBtn = SSBadgeButton()
    var DownLoadBtn = SSBadgeButton()
    private let refreshControl = UIRefreshControl()
    
    var NoDataFound = true
    
     var ScrollUp = false
    
    var LoadMore = false
    var pageCount = 1
     var Filter = "All"
    var params :  [String : Any] = [:]
    var InvoiceList : [InvoiceObject] = []
    var InvoiceListListDummy : [InvoiceObject] = []
    var resultSearchController = UISearchController()
    
    var Title = "You haven't created any invoice"
    var subTitle = "Create your first invoice and get paid for your excellent work."
    var Image = ""

    @IBOutlet weak var tableVw: UITableView!
    
    
    func updateSearchResults(for searchController: UISearchController) {
      
    }
    
    // MARK: - Setup Navigation bar

    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        
        self.tabBarController?.navigationItem.title = "Invoice"

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
     //   self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                self.pageCount = 1

                self.params = ["search_text":"","page": self.pageCount,"count":GlobalConstants.Count,"filter":self.Filter]
                self.GetInvoiceList(param: self.params,isLoader:false,Append: false)
                
            }
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
        tableVw.separatorInset = .zero
        tableVw.tableFooterView = UIView()

        tableVw.alwaysBounceVertical = false
        tableVw.alwaysBounceHorizontal = false

        if CreateButton == true
        {
            btnView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)

            btnView.createCircleForView()
            
        }
        else
        {
            btnView.isHidden = true
        }
        
        
        
        if BackButtonStatus == false
        {
//            let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//            btSlider.tintColor = UIColor.white
//            navigationItem.leftBarButtonItem = btSlider

        }
        
        NavBarFilter()
        
        
        
      
        
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.tableVw.register(nib, forCellReuseIdentifier: "NoDataFound")
        
        
        let LoadMoreNib = UINib.init(nibName: "LoadMore", bundle: nil)
        self.tableVw.register(LoadMoreNib, forCellReuseIdentifier: "LoadMore")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Call Setup Navigation setting Function
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
        // Check Nav Button
        HiddenNavButton()
  
        
    }
    
    
    
    func AddSearchBar()
    {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableVw.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
    }
    
    // MARK: - create New Invoice Action
    @IBAction func createNewInvoice(_ sender: Any) {
        
       
     OpenCreateInvoiceScreen(Title: "New Invoice")
        
    }
    
    func OpenCreateInvoiceScreen(Title:String)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateInvoice") as! CreateInvoice
        vc.ClassType = "Invoice"
        vc.Title = Title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        
    }
    
    // MARK: - Set navigationbar Icons
    
    func NavBarFilter()
    {
        
        FilterBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 16)
        FilterBtn.setImage(UIImage.ionicon(with: .androidOptions, textColor: .white, size: CGSize(width: 30, height: 30)), for: .normal)
        FilterBtn.badgeEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 5)
        
        FilterBtn.badgeLabel.isHidden = true
        FilterBtn.addTarget(self, action: #selector(Filter_Action), for: .touchUpInside)
        let Button1 = UIBarButtonItem(customView: FilterBtn)
       
        
        DownLoadBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 16)
        DownLoadBtn.setImage(UIImage.ionicon(with: .codeDownload, textColor: .white, size: CGSize(width: 30, height: 30)), for: .normal)
        DownLoadBtn.badgeEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 5)
        
        DownLoadBtn.badgeLabel.isHidden = true
        DownLoadBtn.addTarget(self, action: #selector(Download_Action), for: .touchUpInside)
        let Button2 = UIBarButtonItem(customView: DownLoadBtn)
        
        
        if CreateButton == true
        {
            self.navigationItem.rightBarButtonItems = [Button1]
            
        }
        else
        {
            self.navigationItem.rightBarButtonItems = [Button1,Button2]
            
        }
        
        
    }
    
    // MARK: - Download Action
    @objc func Download_Action() {
        
        
        
    }
    // MARK: - Filter Action
    
    
    @objc func Filter_Action(){
        
        if CreateButton == false
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportFilter") as! ReportFilter
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        }
        else{

        
        self.popupAlertWithSheet(title: nil, message: "Filter".uppercased(), actionTitles: [ "All","Unpaid","Overdue","Paid","Draft"], actions:[
            {action1 in
                
                
               
                
                
            },{action2 in
                
                
             
                
                
            },{action3 in
                
                
                
              
                
            },{action4 in
                
                
                
                
                
            },{action5 in
                
                
                
                
                
            }, nil])
    }
    }
    
    
    
    // MARK: - Get Invoice List List API Request
    
    func GetInvoiceList(param : [String : Any],isLoader:Bool,Append:Bool){
        self.view.endEditing(true)
        
        
        InvoiceAPIRequest.shared.Invoice(requestParams: param,isLoader:isLoader) { (obj, msg, success,session) in
            
            print(obj as Any)
            print(msg as Any)
            print(success)
            print(session)
            
            
            if session == true
            {
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                    self.LoadMore = false
                   
                     self.refreshControl.endRefreshing()
                     self.tableVw.reloadData()
                    
                }
                else
                {
                    
                    self.InvoiceListListDummy = obj!
                    
                    
                    if Append == false
                    {
                       self.InvoiceList.removeAll()
                    }
                    
                    self.InvoiceList.append( self.InvoiceListListDummy)
                    
                    if self.InvoiceList.count == 0
                    {
                        self.NoDataFound = true
                        
                    }
                    else
                    {
                        self.NoDataFound = false
                        self.AddSearchBar()
                        
                    }
              
                        if self.InvoiceListListDummy.count == GlobalConstants.Count
                        {
                              self.LoadMore = true
                        }
                    else
                        {
                            self.LoadMore = false
                    }
                    }
                
                    self.refreshControl.endRefreshing()
                    self.tableVw.reloadData()
           
            }
            else{
                
                self.LoadMore = false
                 self.refreshControl.endRefreshing()
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
           
            
        }
        
        
        
        
    }
    
}
    
// MARK: - Table View Delegate/DataSource Methods

extension InvoicesVc : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.OpenCreateInvoiceScreen(Title: "Edit Invoice")

            
        }
       
        // deleteAction.backgroundColor =
        deleteAction.image = UIImage.ionicon(with: .androidDelete, textColor: .white, size: CGSize(width: 32, height: 32))
        editAction.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        editAction.image = UIImage.ionicon(with: .edit, textColor: .white, size: CGSize(width: 32, height: 32))
        
        
        return [deleteAction,editAction]
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  NoDataFound == false
        {
            
          if  self.LoadMore == false
            {
                return InvoiceList.count
                
            }
            else
            {
                return InvoiceList.count + 1
                
            }
            
          
        }
        else
        {
            
            return 1
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if  NoDataFound == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFound", for: indexPath) as! NoDataFound
            self.tableVw.separatorColor = .clear
            cell.NoDataTitle.text = Title
            cell.NoDataSubTitle.text = subTitle
            cell.selectionStyle = .none
            return cell

        }
        else
        {
          
            let totalRows = tableVw.numberOfRows(inSection: indexPath.section)

          if  self.LoadMore == true
           {
                if indexPath.row != totalRows - 1
                {
                    tableView.separatorStyle = .singleLine
                    return CellFunction(indexPath:indexPath)
                }
                else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMore", for: indexPath) as! LoadMore
                    cell.LoaderView .startAnimating()
                    cell.selectionStyle = .none
                    tableView.separatorStyle = .none
                    return cell
                }
            }
            else
          {
            tableView.separatorStyle = .singleLine
            return CellFunction(indexPath:indexPath)
            }
            
        }
        
       


    }
    
    
    func CellFunction(indexPath: IndexPath)-> UITableViewCell
    {
        let cell = tableVw.dequeueReusableCell(withIdentifier: "cell") as! MainCell
        
        let data : InvoiceObject = self.InvoiceList[indexPath.row]
        cell.selectionStyle = .none
        cell.SubTitle_LBL.text = data.po_number
        cell.Title_LBL.text = data.customer_name
        cell.Date_LBL.text = data.invoice_date
        cell.Status_LBL.text = data.status
        cell.Price_LBL.text = data.total_price
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if  self.LoadMore == true
        {
            let totalRows = tableVw.numberOfRows(inSection: indexPath.section)
            
            if indexPath.row == totalRows - 1 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    
                    self.pageCount = self.pageCount + 1
                    // Check Get Tax List
                    self.params = ["search_text":"","page": self.pageCount,"count":GlobalConstants.Count,"filter":self.Filter]
                    self.GetInvoiceList(param: self.params,isLoader:false,Append: true)
                    
                }
                
            }
            
        }
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  NoDataFound == true
        {
            return self.tableVw.frame.size.height

        }
        else
        {
            if  self.LoadMore == false
            {
                 return 124
            }
            else
            {
                 let totalRows = tableVw.numberOfRows(inSection: indexPath.section)
                
                if indexPath.row != totalRows - 1
                {
                     return 124
                }
                else
                {
                     return 50
                }
                
                
            }
         
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if  NoDataFound == false
        {
       OpenCreateInvoiceScreen(Title: "Invoice")
        }

    }
    
  
    
}
extension InvoicesVc: EmptyStateDelegate {
    
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
    
    
    
   
    
    
    func HiddenNavButton() {
        
        if  NoDataFound == true
        {
            FilterBtn.isHidden = true
            DownLoadBtn.isHidden = true

        }
        else
        {
            FilterBtn.isHidden = false
            DownLoadBtn.isHidden = false

            
        }
    }
    
}
