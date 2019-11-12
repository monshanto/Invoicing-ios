

import UIKit
import SDWebImage
import SwipeCellKit
import Letters
import EmptyStateKit
import Alamofire
class AddContact: UIViewController {
    var resultSearchController = UISearchController()

    
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var mtableview: UITableView!
    private let refreshControl = UIRefreshControl()
    fileprivate var FilterString : String = ""
    var BackButtonStatus : Bool = false
    
    var SelectionStatus : Bool = false


    var NoDataFound = false
    var LoadMore = false
    var pageCount = 1
    var Filter = "All"
    
    var Title = "You haven't created any customer"
    var subTitle = "Create your first customer and get paid for your excellent work."
    var Image = ""

    var params :  [String : Any] = [:]
    var CustomerList : [CustomerObject] = []
    var CustomerDummyList : [CustomerObject] = []

    
    var delegate : InvoiceCustomerProtocol?


    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Customers"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            mtableview.refreshControl = refreshControl
        } else {
            mtableview.addSubview(refreshControl)
        }
        
    }
    
    
    @objc private func RefreshCustomerList(notification: NSNotification)
    {
        RefreshScreen()
    }
    
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        
        //  InterNet Check
        if AlamofireRequest.shared.InterNetConnection()
        {
            // Check Get Tax List
            
            pageCount = 1
            
           
          
            params = ["searchQuery":"","sortBy":"","pageNumber": pageCount,"pageSize":GlobalConstants.Count]
            GetCustomerList(param: params,isLoader:false,Append: false)
        }
        else
        {
          
            // Check InterNet Connection
            CheckInterNetConnection()
        }
        
        
        
    }
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.LanguageSet()
        btnView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)

        btnView.createCircleForView()
        lblPlusSign.font = UIFont.ionicon(of: 30)
        lblPlusSign.text = String.ionicon(with: .plus )
        self.mtableview.delegate = self
        self.mtableview.dataSource = self
        self.mtableview.tableFooterView = UIView()
      //  self.mtableview.separatorStyle = .none
        mtableview.rowHeight = UITableView.automaticDimension
        mtableview.estimatedRowHeight = 105
        mtableview.alwaysBounceVertical = false
        mtableview.alwaysBounceHorizontal = false
       mtableview.separatorInset = .zero

        
     
        
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.mtableview.register(nib, forCellReuseIdentifier: "NoDataFound")
        
        let LoadMoreNib = UINib.init(nibName: "LoadMore", bundle: nil)
        self.mtableview.register(LoadMoreNib, forCellReuseIdentifier: "LoadMore")
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
        // Check Nav Button
        HiddenNavButton()
        
        // NotificationCall When Create Customer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.RefreshCustomerList),
            name: NSNotification.Name(rawValue: "RefreshCustomerList"),
            object: nil)
        


        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        // Call Setup Navigation setting Function
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resultSearchController.dismiss(animated: false, completion: nil)
        
    }
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        
    }
    
    // MARK: - create New Contact Action
    @IBAction func createNewContact(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateContact") as! CreateContact
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    // MARK: - SetUp SearchBar
    
    func SetUpSearchBar()
    {
        self.resultSearchController = ({
            
            let controller = UISearchController(searchResultsController: nil)
            // controller.delegate = self
            controller.searchBar.delegate = self
            controller.searchBar.placeholder =  "Search Customer"
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false
            self.mtableview.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        
    }
    
   
    // MARK: - Get Customer List API Request
    
    func GetCustomerList(param : [String : Any],isLoader:Bool,Append:Bool)
    {
        self.view.endEditing(true)
        
        
        CustomerAPIRequest.shared.Customer(requestParams: param,isLoader:isLoader) { (obj, msg, success,session) in
            
            print(obj as Any)
            print(msg as Any)
            print(success)
            print(session)
            
            if session == true
            {
                if success == false {
                    self.LoadMore = false
                    self.refreshControl.endRefreshing()
                    self.mtableview.reloadData()
                    self.MessageAlert(title: "", message: msg!)

                    
                }
                else
                {
                    
                    
                    self.CustomerDummyList = obj!
                    
                    
                    if Append == false
                    {
                        self.CustomerList.removeAll()
                    }
                    
                    self.CustomerList.append( self.CustomerDummyList)
                    
                    if self.CustomerList.count == 0
                    {
                        self.NoDataFound = true
                        
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    if self.CustomerDummyList.count == GlobalConstants.Count
                    {
                        self.LoadMore = true
                    }
                    else
                    {
                        self.LoadMore = false
                        
                    }
                }
                
                self.refreshControl.endRefreshing()
                self.mtableview.reloadData()
                    
  
            }
            else{
                
                self.LoadMore = false
                self.refreshControl.endRefreshing()
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
        
        
    }
    
    
    func MessageAlertDelete(title:String,message:String,PathIndex:Int,User_id:Int)
    {
        
        
        
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Yes" , style: .default, handler:{ (UIAlertAction)in
            
            let param = ["_Id":User_id] as [String : Any]
            
            self.DeleteUserApi(param: param,PathIndex:PathIndex)
            
        }))
        
        alert.addAction(UIAlertAction(title:"No" , style: .cancel, handler:{ (UIAlertAction)in
            
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
    
    // MARK: - Delete Tax API Request
    
    func DeleteUserApi(param : [String : Any],PathIndex:Int){
        DeleteCustomerAPIRequest.shared.DeleteCustomer(requestParams: param, isLoader: true) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.CustomerList.remove(at: PathIndex)
                    
                    if self.CustomerList.count == 0
                    {
                        self.NoDataFound = true
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    self.mtableview.reloadData()
                    
                    
                }else{
                    
                    self.MessageAlert(title:"Invoicing",message: message!)
                    
                }
            }
            else
            {
                self.SessionMessageAlert(title:"Invoicing",message: message!)
                
            }
            
            
        }
    }
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension AddContact : UISearchBarDelegate
{
    // MARK: - updateSearchResults
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != ""
        {
            FilterString = searchBar.text ?? ""
            
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        FilterString = ""
       
        
    }
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension AddContact : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
{
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
  
            if  NoDataFound == false
            {
                
                if  self.LoadMore == false
                {
                    return CustomerList.count
                    
                }
                else
                {
                    return CustomerList.count + 1
                    
                }
                
                
            }
            else
            {
                
                return 1
                
            }
        }
        
        
 
        
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  NoDataFound == true
        {
            return self.mtableview.frame.size.height
            
        }
        else
        {
            return UITableView.automaticDimension
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if  NoDataFound == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFound", for: indexPath) as! NoDataFound
            tableView.separatorStyle = .none
            cell.NoDataTitle.text = Title
            cell.NoDataSubTitle.text = subTitle
            cell.selectionStyle = .none
            return cell
            
        }
        else
        {
          
                let totalRows = tableView.numberOfRows(inSection: indexPath.section)
                
                if  self.LoadMore == true
                {
                    if indexPath.row != totalRows - 1
                    {
                        tableView.separatorStyle = .singleLine
                        return CellFunction(indexPath:indexPath)
                    }
                    else
                    {
                        let cell = mtableview.dequeueReusableCell(withIdentifier: "LoadMore", for: indexPath) as! LoadMore
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
        
                let cell = mtableview.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
        
                    let data : CustomerObject = self.CustomerList[indexPath.row]
                    cell.setCellData(Customer: data)
                    cell.delegate = self
                    mtableview.separatorStyle = .singleLine
                    cell.selectionStyle = .none
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if  self.LoadMore == true
        {
            let totalRows = mtableview.numberOfRows(inSection: indexPath.section)
            
            if indexPath.row == totalRows - 1 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    
                    self.pageCount = self.pageCount + 1
                    
                    // Check Get Customer List
                    self.params = ["searchQuery":"","sortBy":"","pageNumber": self.pageCount,"pageSize":GlobalConstants.Count]
                    
                    // Check Get Customer List
                    self.GetCustomerList(param: self.params,isLoader:false,Append: true)
                    
                    
                    
                }
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        
         let UserData : CustomerObject = self.CustomerList[indexPath.row]
        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
               self.MessageAlertDelete(title: GlobalConstants.Messagetitle, message: "Are you sure you want to delete this User", PathIndex: indexPath.row, User_id: UserData.customer_id)
            
            
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.OpenProfileScreen(title: "Edit Profile",UserData:self.CustomerList[indexPath.row])

            
        }
        
        
        
        // customize the action appearance
        
        // deleteAction.backgroundColor =
        deleteAction.image = UIImage.ionicon(with: .androidDelete, textColor: .white, size: CGSize(width: 32, height: 32))
        editAction.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        editAction.image = UIImage.ionicon(with: .edit, textColor: .white, size: CGSize(width: 32, height: 32))
        
        
        return [deleteAction,editAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        var CustomerInfoDic:[String:Any] = [:]
        let CustomerInfo : CustomerObject = self.CustomerList[indexPath.row]
       CustomerInfoDic = ["customer_id":CustomerInfo.customer_id,"first_name":CustomerInfo.first_name,"last_name":CustomerInfo.last_name,"user_name":CustomerInfo.user_name,"email_id":CustomerInfo.email_id]
       let customer : InvoiceCustomer = InvoiceCustomer.init(model: CustomerInfoDic)
        
        
        self.delegate?.GetCustomer(Customer: [customer])
        
        self.navigationController?.popViewController(animated: true)
        
  
        
    }
    
    
    
    func OpenProfileScreen(title:String,UserData:CustomerObject)
   {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "CreateContact") as! CreateContact
     EditProfileViewController.Customer = UserData.user_name
     EditProfileViewController.Email = UserData.email_id
     EditProfileViewController.FirstName = UserData.first_name
     EditProfileViewController.LastName = UserData.last_name
     EditProfileViewController.Main = "\(UserData.phone)"
     EditProfileViewController.Mobile = "\(UserData.mobile)"
     EditProfileViewController.Website = UserData.website
     EditProfileViewController.Address = UserData.Address
    EditProfileViewController.Customer_id = UserData.customer_id
     EditProfileViewController.ClassType = "edit"

    self.navigationController?.pushViewController(EditProfileViewController, animated: true)
    }
    
}


extension AddContact: EmptyStateDelegate {
    
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
    
            
            // Check Get Tax List
            params = ["searchQuery":"","sortBy":"","pageNumber": pageCount,"pageSize":GlobalConstants.Count]
            GetCustomerList(param: params,isLoader:true,Append: false)
            
        }
        
    }
    
    func HiddenNavButton() {
        
        if  NoDataFound == true
        {
            
        }
        else
        {
           

            
        }
    }
    
}

