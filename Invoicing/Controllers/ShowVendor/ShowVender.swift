

import UIKit
import SDWebImage
import SwipeCellKit
import Letters
import EmptyStateKit
import Alamofire
class ShowVender: UIViewController {
    var resultSearchController = UISearchController()
    
    
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var mtableview: UITableView!
    private let refreshControl = UIRefreshControl()
    fileprivate var FilterString : String = ""
    var SlideButton : Bool = false
    var NoDataFound = false
    var Title = "You haven't created any Vendor"
    var subTitle = "Create your first Vendor and get paid for your excellent work."
    var Image = ""
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Vendors"
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
            mtableview.reloadData()
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

        
        if SlideButton == false
        {
            
//            let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//            btSlider.tintColor = UIColor.white
//            navigationItem.leftBarButtonItem = btSlider
        }
        
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.mtableview.register(nib, forCellReuseIdentifier: "NoDataFound")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
        // Check Nav Button
        HiddenNavButton()
        
        
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
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateVendor") as! CreateVendor
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    // MARK: - SetUp SearchBar
    
    func SetUpSearchBar()
    {
        self.resultSearchController = ({
            
            let controller = UISearchController(searchResultsController: nil)
            // controller.delegate = self
            controller.searchBar.delegate = self
            controller.searchBar.placeholder =  "Search Vendor"
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false
            self.mtableview.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        
    }
    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension ShowVender : UISearchBarDelegate
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

extension ShowVender : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
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
            return 5
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
            self.mtableview.separatorColor = .clear
            cell.NoDataTitle.text = Title
            cell.NoDataSubTitle.text = subTitle
            cell.selectionStyle = .none
            return cell
            
        }
        else
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell  = cell as?  TeamCell
        {
            
            
            //   cell.viewShadow?.bottomViewShadow(ColorName: UIColor.gray)
            cell.imgUser?.setImage(string: "Bhushan Rana", color: nil, circular: true)
            cell.lblUserName.text = "Mr Bhushan Rana"
            cell.lblemailid.text = "ranabhushan87@gmail.com"
            cell.delegate = self
            cell.selectionStyle = .none
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
            
            
            
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.OpenProfileScreen(title: "Edit Profile")

            
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
        
        if  NoDataFound == false
        {
            OpenProfileScreen(title: "Profile")
        }
        

    }
    
    
    
    func OpenProfileScreen(title:String)
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        EditProfileViewController.TitleValue = title
        self.navigationController?.pushViewController(EditProfileViewController, animated: true)
    }
    
}


extension ShowVender: EmptyStateDelegate {
    
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
            
        }
        else
        {
            SetUpSearchBar()
            
            
        }
    }
    
}

