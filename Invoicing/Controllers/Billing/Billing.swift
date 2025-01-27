import UIKit
import SwipeCellKit
import EmptyStateKit
import Alamofire

class Billing: UIViewController {
    
    
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    var BackButtonStatus : Bool = false
    var FilterBtn = SSBadgeButton()
    private let refreshControl = UIRefreshControl()
    var NoDataFound = true
    var Title = "You haven't created any expense"
    var subTitle = "Create your first expense and get paid for your excellent work."
    var Image = ""


    
    
    @IBOutlet weak var tableVw: UITableView!
    
    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        
        self.navigationController?.navigationBar.topItem?.title = "Expenses"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
      //  self.navigationController!.navigationBar.tintColor = BtnColor
        
        
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
        tableVw.separatorInset = .zero
        tableVw.tableFooterView = UIView()

        tableVw.alwaysBounceVertical = false
        tableVw.alwaysBounceHorizontal = false
        tableVw.tableFooterView = UIView()

        btnView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)

        btnView.createCircleForView()
        
        
        
        if BackButtonStatus == false
        {
//            let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//            btSlider.tintColor = UIColor.white
//            navigationItem.leftBarButtonItem = btSlider
            
        }
        
        
       
        
        NavBarFilter()
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.tableVw.register(nib, forCellReuseIdentifier: "NoDataFound")
        
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
    
    // MARK: - create New Quotations Action
    @IBAction func createNewExpence(_ sender: Any) {
        
        OpenCreateNewExpence(Title: "New Expense")
        
    }
    
    
    func OpenCreateNewExpence(Title:String)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateBill") as! CreateBill
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
        
        
        
        
        
        self.navigationItem.rightBarButtonItems = [Button1]
        
        
    }
    
    
    // MARK: - Filter Action
    
    
    @objc func Filter_Action(){
        
        self.popupAlertWithSheet(title: nil, message: "Filter".uppercased(), actionTitles: [ "All","Unbilling","Invoiced","Billable","Non-Billable","With Receipts","Without Receipts"], actions:[
            {action1 in
                
                
                
                
                
            },{action2 in
                
                
                
                
                
            },{action3 in
                
                
                
                
                
            },{action4 in
                
                
                
                
                
            },{action5 in
                
                
                
                
                
            },{action6 in
                
                
                
                
                
            },{action7 in
                
                
                
                
                
            }, nil])
    }
    
}

// MARK: - Table View Delegate/DataSource Methods

extension Billing : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate

    {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.OpenCreateNewExpence(Title: "Edit Expense")

            
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
            return 5
            
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
            let cell = tableVw.dequeueReusableCell(withIdentifier: "cell") as! MainCell
            cell.selectionStyle = .none
            cell.SubTitle_LBL.text = "INVVV-01234"
            cell.delegate = self
            return cell
            
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  NoDataFound == true
        {
            return self.tableVw.frame.size.height
            
        }
        else
        {
            return 124
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  NoDataFound == false
        {
    
        OpenCreateNewExpence(Title: "Expense")
            
        }

    }
    
    
    
}


extension Billing: EmptyStateDelegate {
    
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
            FilterBtn.isHidden = true
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
        }
        else
        {
            FilterBtn.isHidden = false
            
        }
    }
}

