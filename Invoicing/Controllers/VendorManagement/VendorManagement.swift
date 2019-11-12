
import UIKit
import LocalAuthentication
import IoniconsKit
import Social
import MessageUI
import EmptyStateKit
import Alamofire


class VendorManagement: UIViewController,MFMailComposeViewControllerDelegate {
    
    
    var  cell = UITableViewCell()
    var arrSctionTitle = [String]()
    @IBOutlet weak var mTableView: UITableView!
    
    
    // MARK: - Setup Navigation bar
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Vendor Management"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
    }
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        arrSctionTitle = ["Create Vendor","Receive Invoice"]
        
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.tableFooterView = UIView()
        self.mTableView.alwaysBounceVertical = false
        self.mTableView.alwaysBounceHorizontal = false
        
        
//        let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//        btSlider.tintColor = UIColor.white
//        navigationItem.leftBarButtonItem = btSlider
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
    }
    
    
    
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        
    }
    
    
}




// MARK: - Table View Delegate/DataSource Methods

extension VendorManagement: UITableViewDelegate,UITableViewDataSource
{
    
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSctionTitle.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 70
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        
        // cell.Title_LBL.font = SystemFont(FontSize: 22)
        cell.Title_LBL.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        cell.Title_LBL.textColor = UIColor.black
        cell.Title_LBL.text = arrSctionTitle[indexPath.row]
        cell.SubTitle_LBL.text = ""
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        if indexPath.row == 0
        {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let ShowVendortobj =  storyboard.instantiateViewController(withIdentifier: "ShowVender") as! ShowVender
            ShowVendortobj.SlideButton = true

            self.navigationController?.pushViewController(ShowVendortobj, animated: true)
        }
        else if indexPath.row == 1
        {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let VendorRequestsobj =  storyboard.instantiateViewController(withIdentifier: "VendorRequests") as! VendorRequests
            VendorRequestsobj.BackButtonStatus = true
            self.navigationController?.pushViewController(VendorRequestsobj, animated: true)
        }
            
       
        
        
    }
    
    
    
}



extension VendorManagement: EmptyStateDelegate {
    
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


