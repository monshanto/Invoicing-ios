

import UIKit
import SwipeCellKit
import EmptyStateKit
import Alamofire

class ItemList: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    private let refreshControl = UIRefreshControl()
    var SideButton : Bool = false
    
    var NoDataFound = false
    var LoadMore = false
    var pageCount = 1
    var Filter = "All"

    var Title = "You haven't created any item"
    var subTitle = "Create your first item and get paid for your excellent work."
    var Image = ""
    
    var params :  [String : Any] = [:]
    var ItemList : [ItemObject] = []
     var ItemListDummy : [ItemObject] = []
    
    
    var ItemInfoDic:[String:Any] = [:]
    var ItemInfoArray:[Any] = []
    
    let button = UIButton()

    var items =  [UIBarButtonItem]();
    var delegate : InvoiceItemProtocolo?

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Items"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    
    @objc private func RefreshItemList(notification: NSNotification)
    {
        RefreshScreen()
    }
    
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        
        //  InterNet Check
        if AlamofireRequest.shared.InterNetConnection()
        {
            pageCount = 1
            params = ["searchQuery":"","pageNumber": pageCount,"pageSize":GlobalConstants.Count]
            GetItemList(param: params,isLoader:false,Append: false)
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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.alwaysBounceVertical = false
        self.tableView.alwaysBounceHorizontal = false
        self.tableView.separatorInset = .zero
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false

        btnView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)

        btnView.createCircleForView()
        lblPlusSign.font = UIFont.ionicon(of: 30)
        lblPlusSign.text = String.ionicon(with: .plus )
        
        
//      if SideButton == true
//        {
//            let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//            btSlider.tintColor = UIColor.white
//            navigationItem.leftBarButtonItem = btSlider
//        }
//
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NoDataFound")
        
        
        
        let nibs = UINib.init(nibName: "LoadMore", bundle: nil)
        self.tableView.register(nibs, forCellReuseIdentifier: "LoadMore")
        
        
         //  RightActionButton(Title: "Done")
        
        
        // NotificationCall When Create Customer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.RefreshItemList),
            name: NSNotification.Name(rawValue: "RefreshItemList"),
            object: nil)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        self.navigationController?.isNavigationBarHidden = false
        
      
        
    }
    
    ///// Add Client / Save Button
    
    func RightActionButton(Title:String){
        
        button.removeFromSuperview()
        button.frame =  CGRect(x: 0, y: 0, width: 70, height: 20)
        button.contentVerticalAlignment = .bottom
        button .setTitle(Title, for: .normal)
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.rightBarButtonItems = items

    }
    
    ///// Add Client / Save Button Action
    
    @objc func rightButtonAction(){
        
        
       
    
    }
    
    // MARK: - createTax
    @IBAction func createItem(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddItems") as! AddItems
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        
    }
    
    
    
    // MARK: - Get Tax List API Request
    
    func GetItemList(param : [String : Any],isLoader:Bool,Append:Bool){
        self.view.endEditing(true)
        
        
        ItemAPIRequest.shared.Item(requestParams: param,isLoader:isLoader) { (obj, msg, success,session) in
            
            print(obj as Any)
            print(msg as Any)
            print(success)
            print(session)
            
            if session == true
            {
                if success == false {
                    self.LoadMore = false
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    self.MessageAlert(title: "", message: msg!)
                    
                    
                }
                else
                {
                    
                    
                    self.ItemListDummy = obj!
                    
                    
                    if Append == false
                    {
                        self.ItemList.removeAll()
                    }
                    
                    self.ItemList.append( self.ItemListDummy)
                    
                    if self.ItemList.count == 0
                    {
                        self.NoDataFound = true
                        
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    if self.ItemListDummy.count == GlobalConstants.Count
                    {
                        self.LoadMore = true
                    }
                    else
                    {
                        self.LoadMore = false
                        
                    }
                }
                
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                
                
            }
            else{
                
                self.LoadMore = false
                self.refreshControl.endRefreshing()
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
        
        
    }
    
    
    // MARK: - Delete Tax API Request
    
    func DeleteTaxApi(param : [String : Any],PathIndex:Int){
        ItemDeleteAPIRequest.shared.ItemDelete(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.ItemList.remove(at: PathIndex)
                    
                    if self.ItemList.count == 0
                    {
                        self.NoDataFound = true
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    
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

extension ItemList : UITableViewDelegate , UITableViewDataSource, SwipeTableViewCellDelegate
{
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if  NoDataFound == false
        {
            
            if  self.LoadMore == false
            {
                return ItemList.count
                
            }
            else
            {
                return ItemList.count + 1
                
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
            self.tableView.separatorColor = .clear
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
         let data : ItemObject = self.ItemList[indexPath.row]
        cell.setCellData(Items: data)
        cell.delegate = self
        tableView.separatorStyle = .singleLine
        cell.selectionStyle = .none
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if  self.LoadMore == true
        {
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            
            if indexPath.row == totalRows - 1 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    
                    self.pageCount = self.pageCount + 1
                    
                    // Check Get Customer List
                    self.params = ["searchQuery":"","sortBy":"","pageNumber": self.pageCount,"pageSize":GlobalConstants.Count]
                    
                    // Check Get Customer List
                    self.GetItemList(param: self.params,isLoader:false,Append: true)
                    
                    
                    
                }
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  NoDataFound == true
        {
            return self.tableView.frame.size.height
            
        }
        else
        {
            return 80
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let ItemValue : ItemObject = self.ItemList[indexPath.row]

        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
            
            self.MessageAlertDelete(title: GlobalConstants.Messagetitle, message: "Are you sure you want to delete this item", PathIndex: indexPath.row, Item_id: ItemValue.id)
            
           
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.EditItemScreen(title: "edit",UserData:self.ItemList[indexPath.row])
            
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
      //  let ItemInfo : ItemObject = self.ItemList[indexPath.row]
//
//
//        if  ItemInfo.Selected == 1
//        {
//            ItemInfo.Selected =  0
//
//
//
//        }
//        else
//        {
//            ItemInfo.Selected =  1
//
//               ItemInfoDic = ["title":ItemInfo.title,"_id":ItemInfo.id,"description":"\(ItemInfo.descriptions )","quantity":ItemInfo.quantity,"total":ItemInfo.Price]
//             ItemInfoArray.append(ItemInfoDic)
//
//        }
//        tableView.reloadData()
//
//
//
//
//
//
//
//        print(ItemInfoArray.count)
//        print(ItemInfoArray)

        
          self.EditItemScreen(title: "add",UserData:self.ItemList[indexPath.row])
        
        
    }
  
    
    func MessageAlertDelete(title:String,message:String,PathIndex:Int,Item_id:Int)
    {
        
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Yes" , style: .default, handler:{ (UIAlertAction)in
            
            let param = ["_Id":Item_id] as [String : Any]
            
            self.DeleteTaxApi(param: param,PathIndex:PathIndex)
            
        }))
        
        alert.addAction(UIAlertAction(title:"No" , style: .cancel, handler:{ (UIAlertAction)in
            
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
    
    
    func EditItemScreen(title:String,UserData:ItemObject)
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let AddItemsViewController =  storyboard.instantiateViewController(withIdentifier: "AddItems") as! AddItems
         AddItemsViewController.ItemNameValue = UserData.title
         AddItemsViewController.ItemDescriptionValue = UserData.descriptions
        AddItemsViewController.ItemQuantity = UserData.quantity
         AddItemsViewController.ItemPrice = UserData.Price
        AddItemsViewController.ItemTax = UserData.Tax
        AddItemsViewController.ItemID = UserData.id
        AddItemsViewController.delegate = self

         AddItemsViewController.ClassType = title
        self.navigationController?.pushViewController(AddItemsViewController, animated: true)
    }
    
    
    }
    
    
    
    




extension ItemList: EmptyStateDelegate {
    
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
            
           
            // Check Get Tax List
            params = ["searchQuery":"","pageNumber": pageCount,"pageSize":GlobalConstants.Count]
            GetItemList(param: params,isLoader:true,Append: false)
            view.emptyState.hide()
            
        }
        
    }
}


extension ItemList : InvoiceItemProtocolo
{
    func GetItems(Items:[InvoiceItems])
    {
        
        print(Items)
        
        
    }
    
    
    
}
