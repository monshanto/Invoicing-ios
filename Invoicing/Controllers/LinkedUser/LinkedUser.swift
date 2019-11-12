

import UIKit
import SDWebImage
import SwipeCellKit
import Letters
import EmptyStateKit
import Alamofire

class LinkedUser: UIViewController {

    
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var mtableview: UITableView!
    private let refreshControl = UIRefreshControl()
    var NoDataFound = false
    var Title = "You haven't linked any user"
    var subTitle = ""
    var Image = ""
    
    var params :  [String : Any] = [:]
    var LinkedUser : [LinkedObject] = []

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Linked User"
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
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
    
        //  InterNet Check
        if AlamofireRequest.shared.InterNetConnection()
        {
            // Check Get Tax List
            GetLinkedUserList(param: [:],isLoader:false)
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
        mtableview.rowHeight = UITableView.automaticDimension
        mtableview.estimatedRowHeight = 105
        mtableview.alwaysBounceVertical = false
        mtableview.alwaysBounceHorizontal = false
        self.mtableview.showsHorizontalScrollIndicator = false
        self.mtableview.showsVerticalScrollIndicator = false
        mtableview.separatorInset = .zero
        btnView.isHidden = true
        
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.mtableview.register(nib, forCellReuseIdentifier: "NoDataFound")
        

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - create New Contact Action
    @IBAction func createNewContact(_ sender: Any) {
        
    }
    
    
    // MARK: - Get Tax List API Request
    
    func GetLinkedUserList(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        LinkedUserAPIRequest.shared.LinkedUser(requestParams: param,isLoader:isLoader) { (obj, msg, success,session) in
            
            print(obj as Any)
            print(msg as Any)
            print(success)
            print(session)
            
            
            if session == true
            {
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                }
                else
                {
                    self.LinkedUser = obj!
                    
                    if self.LinkedUser.count == 0
                    {
                        self.NoDataFound = true
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    
                    
                    self.mtableview.reloadData()
                    
                    
                }
            }
            else{
                
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            self.refreshControl.endRefreshing()

        }
        
        
        
        
    }
    
    func MessageAlertDelete(title:String,message:String,PathIndex:Int,User_id:String)
    {
        
        print("User_id:---->",User_id)
        
        
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
        DeleteLinkedUserAPIRequest.shared.DeleteLinkedUser(requestParams: param, isLoader: true) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.LinkedUser.remove(at: PathIndex)
                    
                    if self.LinkedUser.count == 0
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

extension LinkedUser : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
{
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if  NoDataFound == true
        {
            return 1
            
        }
        else
        {
            return LinkedUser.count
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
        
        if NoDataFound == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFound", for: indexPath) as! NoDataFound
            self.mtableview.separatorColor = .clear
            cell.NoDataTitle.text = Title
            cell.NoDataSubTitle.text = subTitle
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            
            let data : LinkedObject = self.LinkedUser[indexPath.row]

                   let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
                            cell.setCellData(LinkedUser: data)
                            cell.delegate = self
                            cell.selectionStyle = .none
                             self.mtableview.separatorColor = .gray
                    return cell
        }
        
 
        
    }
    
   
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let UserData : LinkedObject = self.LinkedUser[indexPath.row]

        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            self.MessageAlertDelete(title: GlobalConstants.Messagetitle, message: "Are you sure you want to delete this User", PathIndex: indexPath.row, User_id: UserData.user_id)
            
         
        }
     
        
       // deleteAction.backgroundColor =
        deleteAction.image = UIImage.ionicon(with: .androidDelete, textColor: .white, size: CGSize(width: 32, height: 32))
      
        return [deleteAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if  NoDataFound == false
        {
       
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        EditProfileViewController.TitleValue = "Profile"
        self.navigationController?.pushViewController(EditProfileViewController, animated: true)
            
        }
        
}

}

extension LinkedUser: EmptyStateDelegate {
    
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
            refreshControl.endRefreshing()
        }
        else
        {
            
            // Check Get Tax List
            GetLinkedUserList(param: [:],isLoader:true)
            view.emptyState.hide()
            
        }
        
    }

}
