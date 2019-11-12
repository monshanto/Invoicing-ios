

import UIKit
import SDWebImage
import SwipeCellKit
import Letters
import EmptyStateKit
import Alamofire

class Logs: UIViewController {
    
    
    
    @IBOutlet weak var mtableview: UITableView!
    private let refreshControl = UIRefreshControl()
    var NoDataFound = false
    var Title = "You haven't get any notification"
    var subTitle = ""
    var Image = ""
    
    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Logs"
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
    
    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension Logs : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
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
            return 12
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
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
            
            cell.delegate = self
            cell.selectionStyle = .none
            self.mtableview.separatorColor = .gray
            
            cell.lblUserName.font = .TitleRegular()
            cell.lblemailid.font = .LightSmaillFont()
            return cell
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
            
            
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
            
            
        }
        
    }
    
}

extension Logs: EmptyStateDelegate {
    
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
            //  GetLinkedUserList(param: [:],isLoader:true)
            view.emptyState.hide()
            
        }
        
    }
    
}


