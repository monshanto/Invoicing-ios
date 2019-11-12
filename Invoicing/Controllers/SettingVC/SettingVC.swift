
import UIKit
import LocalAuthentication
import IoniconsKit
import Social
import MessageUI
import EmptyStateKit
import Alamofire
import EPSignature
class SettingVC: UIViewController,MFMailComposeViewControllerDelegate {
    
    var currentType : Bool = true
    var arrSettingMenuList = [String]()
    var arrSctionTitle = [String]()
    var arrAccountTitle = [String]()
    var arrInvoiceTitle = [String]()
    var arrCurrencytitle = [String]()


    var  cell = UITableViewCell()
    var gradePicker: UIPickerView!
    
    let gradePickerValues = ["USD","CAD","EUR","AED","AFN","AUD","HNL","ILS","INR"]
    
    let del = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var mTableView: UITableView!

    
    // MARK: - Setup Navigation bar
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        
        self.navigationController?.navigationBar.topItem?.title = "Setting"

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
     //   self.navigationController!.navigationBar.tintColor = BtnColor
        
    }
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrSctionTitle = ["Account","Invoice","Screen Lock","Other"]
        
        arrSettingMenuList = ["Invite People","Contact Us","Sign Out"]
        arrInvoiceTitle = ["Customize Invoice","Invoice Defaults","Items","Statement","Signature","MemberShip"]
        
        arrAccountTitle = ["Linked User","Currency","Edit Profile","Change Password","Logs"]
        
        print(arrSctionTitle)
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.tableFooterView = UIView()
        self.mTableView.alwaysBounceVertical = false
        self.mTableView.alwaysBounceHorizontal = false

        let btNotification = UIBarButtonItem(image: UIImage.ionicon(with: .androidNotifications, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenbtNotification))
        btNotification.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = btNotification
        
        if AppUser.userType == UserType.SubAdmin.rawValue
        {
            arrAccountTitle.removeFirst()
        }
        
       
     
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
    
    // MARK: - DueDay Multiple section Option
    
    @objc func DueDayOption(){
 
        self.popupAlertWithSheet(title: nil, message: nil, actionTitles: ["AUD"], actions:[
            {action1 in
                
                
                
            },{action2 in
                
                
                
                
            },{action3 in
                
                
                
                
            },{action4 in
                
                
                
                
            },{action5 in
                
                
                
                
            },{action6 in
                
                
                
                
            },{action7 in
                
                
                
                
            },{action8 in
                
                
                
                
            },{action9 in
                
                
                
                
            }, nil])
        
        
    }
    
    
    
   
    
}




// MARK: - Table View Delegate/DataSource Methods

extension SettingVC: UITableViewDelegate,UITableViewDataSource
{
    
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section) {
            
        case 0:return arrAccountTitle.count
        case 1:return arrInvoiceTitle.count
        case 2:return 2
        case 3:return arrSettingMenuList.count
            
        default :return 1
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrSctionTitle.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = (arrSctionTitle[section] ).uppercased()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.darkGray
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(label)
        
        
        if section == 2 || section == 3
        {
           headerView.isHidden = true
        }
        else
        {
            headerView.isHidden = false
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 || section == 1
        {
             return 50
        }
//        else if section == 1
//        {
//             return 40
//        }
        else
        {
            return 20
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 3
        {
            if currentType == true
            {
                return 50
            }
            else
                
            {
                return 104
            }
        }
        else
        {
            return 50
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
          if indexPath.section == 0 {
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            
           // cell.Title_LBL.font = SystemFont(FontSize: 22)
            cell.Title_LBL.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
            cell.SubTitle_LBL.textColor = UIColor.black
           
            if indexPath.row == 1
            {
                if AppUser.userType == UserType.Admin.rawValue
                {
                cell.SubTitle_LBL.text = AppUser.currency
                cell.accessoryType = .none
                 cell.SubTitle_LBL.textColor = UIColor.lightGray
                }
                else
                {
                    cell.SubTitle_LBL.text = ""
                    cell.accessoryType = .disclosureIndicator
                }

            }
            else
            {
                if AppUser.userType == UserType.Admin.rawValue
                {
                    cell.SubTitle_LBL.text = ""
                    cell.accessoryType = .disclosureIndicator
                    
                   
                    
                }
                else
                {
                    
                    cell.SubTitle_LBL.text = AppUser.currency
                    cell.accessoryType = .none
                    cell.SubTitle_LBL.textColor = UIColor.lightGray
                }

            }
            
            cell.Title_LBL.text = (arrAccountTitle[indexPath.row] as? String)?.capitalized
            cell.selectionStyle = .none
            return cell
            
        }
            
            else if indexPath.section == 1
          {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
                
              //  cell.Title_LBL.font = SystemFont(FontSize: 22)
                cell.Title_LBL.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
                
                cell.Title_LBL.text = (arrInvoiceTitle[indexPath.row] as? String)?.capitalized
                cell.SubTitle_LBL.textColor = UIColor.clear
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
                
            }
            
            
            
          else  if indexPath.section == 2 {
            
            
            
            if currentType == true
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
                
                
                if indexPath.row == 0
                {
                     cell.lblTitle.text = "Require Touch ID"
                }
                else
                {
                     cell.lblTitle.text = "Notification"
                }
                
               
                cell.lblTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                cell.lblTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
                let userdefault = UserDefaults.standard
                if userdefault.value(forKey:"FaceIdEnable") as? Bool == true
                {
                    cell.swSwitch.isOn = true
                }
                else
                {
                    cell.swSwitch.isOn = false
                }
                
                
                cell.swSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: UIControl.Event.valueChanged)
                
                
                cell.swSwitch.onTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
                cell.selectionStyle = .none
                return cell
                
            }
                
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TouchIDCell") as! TouchIDCell
                cell.LblTouchID?.text = "To use Screen Lock,you need to set up Face ID on your iPhone.Go to iPhone Setting and tap Face ID to get started."
                return cell
                
            }
            
            
          }
            
        else  if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            
         //   cell.Title_LBL.font = SystemFont(FontSize: 22)
            cell.Title_LBL.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
            
            cell.Title_LBL.text = (arrSettingMenuList[indexPath.row] as? String)?.capitalized
            cell.SubTitle_LBL.textColor = UIColor.clear
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
            
        }
            
       
            
     
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                
                if AppUser.userType == UserType.Admin.rawValue
                {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "LinkedUser") as! LinkedUser
                    self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                }
                else
                {
                    
                    DueDayOption()

                }
                
               
            }
                else if indexPath.row == 1
            {
                
                if AppUser.userType == UserType.Admin.rawValue
                {
                    DueDayOption()
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                    EditProfileViewController.TitleValue = "Edit Profile"
                    self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                }
                
            }
                
            else if indexPath.row == 2
            {
                
                if AppUser.userType == UserType.Admin.rawValue
                {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                EditProfileViewController.TitleValue = "Edit Profile"
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePassword
                    self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                }
                
            }
                
            else if indexPath.row == 3
            {
               
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePassword
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                
            }
            
            else if indexPath.row == 4
            {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "Logs") as! Logs
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                
            }
            
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "InvoiceCustomization") as! InvoiceCustomization
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
                
            }
            else if indexPath.row == 1
            {
               
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "InvoiceDefaults") as! InvoiceDefaults
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
            }
           
            else if indexPath.row == 2
            {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                       let Switchobj = storyboard.instantiateViewController(withIdentifier: "ItemList") as? ItemList
                       Switchobj?.SideButton = true
                self.navigationController?.pushViewController(Switchobj!, animated: true)
                
            }
            else if indexPath.row == 3
            {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let Switchobj = storyboard.instantiateViewController(withIdentifier: "StatementsVC") as? StatementsVC
                self.navigationController?.pushViewController(Switchobj!, animated: true)
                
            }
            else if indexPath.row == 4
            {
                let signatureVC = EPSignatureViewController(signatureDelegate: self as EPSignatureDelegate, showsDate: false, showsSaveSignatureOption: false)
                signatureVC.subtitleText = ""
                self.navigationController?.pushViewController(signatureVC, animated: true)
            }
           
            else if indexPath.row == 5
            {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let Switchobj = storyboard.instantiateViewController(withIdentifier: "IntroductionController") as? IntroductionController
                self.navigationController?.pushViewController(Switchobj!, animated: true)
                
            }
            
        }
        else if indexPath.section == 2
        {
           
        }
        else if indexPath.section == 3
        {
           if  indexPath.row == 0
            {
                // text to share
                let text = "This is some text that I want to share."
                
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            }
            else if indexPath.row == 1
            {
                
                if MFMailComposeViewController.canSendMail() {

                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.setToRecipients(["exampleEmail@email.com"])
                composeVC.setSubject("Message Subject")
                composeVC.setMessageBody("Message content.", isHTML: false)
                
                // Present the view controller modally.
                self.present(composeVC, animated: true, completion: nil)
                }
                else
                {
                    print("Application is not able to send an email")

                }
            }
            else
            {
                self.ActionSheet()
            }
            
        }
        
        
        
       
        
    }
    
    
    func ActionSheet()
    {
        
        let alert = UIAlertController(title: nil, message:  nil, preferredStyle: .actionSheet)
        
       
        
        
        
        
        alert.addAction(UIAlertAction(title: "Are you sure you want To Sign Out?", style: .destructive , handler:{ (UIAlertAction)in
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: .default , handler:{ (UIAlertAction)in
            
            
           
            self.callLogOutApi()
            
           
            
        }))
        
       
        
        alert.addAction(UIAlertAction(title:"Cancel" , style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    
    func callLogOutApi(){
        
        print(AppUser.accessToken as Any)
        
        
        LogoutAPIRequest.shared.Logout(requestParams:[:]) { (message, status) in
            
            if status == true{
                self.del.setRoot()
                
            }else{
                
                self.MessageAlert(title:"",message: message!)
                
            }
        }
    }
    
    //MARK: MFMail Compose ViewController Delegate method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: - switch Changed

    @objc func switchChanged(_ sender: UISwitch) {
        
        let userdefault = UserDefaults.standard
        if sender.isOn
        {
                userdefault.set(true, forKey:"FaceIdEnable")
        }
        else
        {
            userdefault.set(false, forKey:"FaceIdEnable")
        }
        
        userdefault.synchronize()
        
    }
    
}



extension SettingVC: EmptyStateDelegate {
    
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


// MARK: - Signature Delegate

extension SettingVC : EPSignatureDelegate
{
    func epSignature(_ signature: EPSignatureViewController, didCancel error : NSError) {
       
        
   //     self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        print(signatureImage)
        
    //    image_Upload_Api(sign: signatureImage, Contact_id: selectedContactId,urlString:"/visitcontactaddsignature" ,imageName: "signature")
    }
   
    
}
