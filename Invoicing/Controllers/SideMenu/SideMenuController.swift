
import UIKit
import SDWebImage
import IoniconsKit

class SideMenuController: UIViewController{
    
   @IBOutlet weak var tableview: UITableView!
    private let refreshControl = UIRefreshControl()


    
    var object  = SideMenuModelClass()
    
    
    
    @IBAction func MembershipAction(_ sender: Any) {
        
   
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let Switchobj = storyboard.instantiateViewController(withIdentifier: "IntroductionController") as? IntroductionController
        SwitchToview(ClassName: Switchobj!)

        
//        self.popupAlertWithSheet(title: nil, message: "Choose your plan", actionTitles: [ "1 MONTH - $25.99","6 MONTH - $99.99","1 YEAR - $199.99"], actions:[
//            {action1 in
//
//
//
//
//
//            },{action2 in
//
//
//
//
//
//            },{action3 in
//
//
//
//
//
//            }, nil])
        
    }
    
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.alwaysBounceVertical = false
        tableview.alwaysBounceHorizontal = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.showsVerticalScrollIndicator = false
        
        
        
        
        
        tableview.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)

        object.nameArray = ["Income","Expense","Debt Collection"]
        
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableview.refreshControl = refreshControl
        } else {
            tableview.addSubview(refreshControl)
        }
       
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
       
    }
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        tableview.reloadData()
        refreshControl.endRefreshing()
    }

}

// MARK: - Table View Delegate/DataSource Methods

extension SideMenuController: UITableViewDelegate,UITableViewDataSource
{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return object.nameArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
    cell.lblName.text = object.nameArray[indexPath.row]
    
    cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
    cell.selectedBackgroundView = view.CustomeView(Color:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 0.5))
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 92
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerVw = Bundle.main.loadNibNamed("HeaderView", owner: self, options: [:])?.last as! HeaderView
    headerVw.image_View.layer.cornerRadius = headerVw.image_View.frame.height/2
    
    if AppUser.userImage != "" ||  AppUser.userImage != " "
    {
      
        headerVw.image_View.sd_setImage(with:URL(string: "http://10.11.12.67:8080/IMC/javax.faces.resource/default/images/DR196.png.xhtml?In=default"), placeholderImage: UIImage(named: "DemoUser"))
    }
    headerVw.lbl_Name.text = AppUser.name
    headerVw.lbl_Email.text = AppUser.email
        headerVw.BTN_Home.backgroundColor = UIColor.clear
   // headerVw.BTN_Home.setBackgroundImage(UIImage.ionicon(with: .iosHome, textColor: UIColor.white, size: CGSize(width: 35, height: 35)), for: .normal)
    headerVw.BTN_Home.addTarget(self, action: #selector(GoToHome), for: .touchUpInside)
    return headerVw
}
    
    
    @objc func GoToHome() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let Switchobj = storyboard.instantiateViewController(withIdentifier: "DashboardVc") as? DashboardVc
        self.SwitchToview(ClassName: Switchobj!)
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.row == 0 {
       
      
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let Switchobj = storyboard.instantiateViewController(withIdentifier: "InvoiceManagement") as? InvoiceManagement
        self.SwitchToview(ClassName: Switchobj!)


    }
 
    else if indexPath.row == 1{

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let Switchobj = storyboard.instantiateViewController(withIdentifier: "Billing") as? Billing
        self.SwitchToview(ClassName: Switchobj!)

    }

    else if indexPath.row == 2 {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let Switchobj = storyboard.instantiateViewController(withIdentifier: "DebtCollection") as? DebtCollection
        self.SwitchToview(ClassName: Switchobj!)
      
        
    }
        
  
    
    
}
    
    func SwitchToview(ClassName:UIViewController) {
        
        let navigationController = UINavigationController(rootViewController: ClassName)
        sideMenuController?.rootViewController = navigationController
        
        self.sideMenuController?.toggleLeftViewAnimated(nil)

        
    }

}
