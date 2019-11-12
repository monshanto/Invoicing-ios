

import UIKit
import SDWebImage
import IoniconsKit
import EmptyStateKit
import Alamofire
class EditProfileVC: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    var arrSctionTitle = [String]()
    var arrRowTitle = NSArray()
    var gender : String? = "Male_PH"
    var TitleValue : String? = ""
    var imageBool : Bool = false
    
    @IBOutlet weak var mTableview: UITableView!
    @IBOutlet weak var imgUserPic: UIImageView!
    
    var User_Info : ShowProfileObject?
    var params :  [String : Any] = [:]

    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imagePicker.delegate = self
        self.title = TitleValue
        
        
        
        
       
        
        
        arrSctionTitle = ["CUSTOMER DETAILS",""]
        
        arrRowTitle = ["Email Id","Name","Company Name","Address","Phone No","Web Address"]
        
        let UserPicGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserPicAction))
        UserPicGestureRecognizer.numberOfTapsRequired = 1
        imgUserPic.addGestureRecognizer(UserPicGestureRecognizer)
        
        
        mTableview.delegate = self
        mTableview.dataSource = self
        mTableview.tableFooterView = UIView()
        mTableview.alwaysBounceVertical = false
        mTableview.alwaysBounceHorizontal = false
        
        
        if TitleValue == "Edit Profile"
        {
            RightActionButton(Title: "Update")
            imgUserPic.isUserInteractionEnabled = true
        }
        else
        {
            imgUserPic.isUserInteractionEnabled = false
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
    }
    
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }
    ///// Add Client / Save Button
    
    func RightActionButton(Title:String){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
        button.contentVerticalAlignment = .bottom
        button .setTitle(Title, for: .normal)
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        var items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.rightBarButtonItems = items
    }
    
    
    ///// Add Client / Save Button Action
    
    @objc func rightButtonAction(){
        
        // Check Get Tax List
        params = ["name":User_Info!.user_name,"phone_no":User_Info!.phone_no,"company_name":User_Info!.company_name,"web_address":User_Info!.web_address]
        UpdateUserProfile(param: params,isLoader:true)
        
    }
    
    // MARK: - Get User Image Action
    
    
    @objc func UserPicAction(recognizer: UITapGestureRecognizer) {
        
        ActionSheet()
        
    }
    
    // MARK: - Open Action Sheet
    
    
    func ActionSheet()
    {
        
        let alert = UIAlertController(title: nil, message:  "Choose option", preferredStyle: .actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default , handler:{ (UIAlertAction)in
            
            self.openCamera()
            
        }))
        
        alert.addAction(UIAlertAction(title:  "Choose Photo", style: .default , handler:{ (UIAlertAction)in
            
            self.photoLibrary()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Photo", style: .destructive , handler:{ (UIAlertAction)in
            
            self.imgUserPic.image = UIImage(named: "DummyUser")
            self.imageBool = false
            
           
            self.DeleteProfilePic(param:[:])
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title:"Cancel" , style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    
    
    // MARK: - Open Camera
    
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            navigationController!.setNavigationBarHidden(true, animated: false)
            // Add it as a subview
            
            addChild(imagePicker)
            view.addSubview(imagePicker.view)
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    // MARK: - Open Photo Library
    
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            navigationController!.setNavigationBarHidden(true, animated: false)
            // Add it as a subview
            
            addChild(imagePicker)
            view.addSubview(imagePicker.view)
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    
    // MARK: - Get User Profile API Request
    
    func GetUserProfile(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        ShowUserProfileAPIRequest.shared.ShowUserProfile(requestParams: param) { (obj, msg, success,session) in
            
            
            if session == true
            {
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                }
                else
                {
                    
                    self.User_Info = obj
                    
                    if self.User_Info?.profile_pic == "" || self.User_Info?.profile_pic == " "
                    {
                        self.imageBool = false
                    }
                    else
                    {
                        self.imageBool = true

                    }
                    
                    
                    self.imgUserPic.sd_setImage(with:URL(string: self.User_Info!.profile_pic), placeholderImage: UIImage(named: "DummyUser"))
                    
                    self.mTableview.reloadData()
                    
                    
                }
            }
            else{
                
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
        
        
    }
    
    
    
    // MARK: - Update User Information API Request

    func UpdateUserProfile(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        EditProfileAPIRequest.shared.EditProfile(requestParams: param) { (obj, msg, success,session) in
            
            
            if session == true
            {
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                }
                else
                {
                    
                    AppUser.name = self.User_Info!.user_name
                    
                    self.MessageAlert(title: "", message: msg!)

                    
                    
                }
            }
            else{
                
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
        
        
    }
    
    
    // MARK: - Delete User pic API Request

    func DeleteProfilePic(param : [String : Any]){
        DeleteProfilePicAPIRequest.shared.DeleteProfilePic(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    
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
    
    
    
    // MARK: - Update User pic API Request
    
    func UpdateProfilePic(param : Data){
        UpdateProfilePicAPIRequest.shared.UpdateProfilePic(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    
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

extension EditProfileVC: UITableViewDelegate,UITableViewDataSource
{
    
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrRowTitle.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        
        
        return arrSctionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
        
        
        
        
        
        print(User_Info?.email_id as Any)
        
        
        if indexPath.row == 0
        {
            
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            cell.Invoice_txt.placeholder = User_Info?.email_id
            cell.Invoice_txt.isUserInteractionEnabled = false
        }
        else if indexPath.row == 1
            
        {
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            cell.Invoice_txt.text = User_Info?.user_name
            
            cell.Invoice_txt.isUserInteractionEnabled = true
            
            
            
        }
        else if indexPath.row == 2
        {
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            cell.Invoice_txt.text = User_Info?.company_name
            
            cell.Invoice_txt.isUserInteractionEnabled = true
            
            
            
        }
        else if indexPath.row == 3
        {
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            
            cell.Invoice_txt.isUserInteractionEnabled = true
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.Invoice_txt.isHidden = true
        }
        else if indexPath.row == 4
        {
            cell.Invoice_txt.keyboardType = .numberPad
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            cell.Invoice_txt.text = User_Info?.phone_no
            
            cell.Invoice_txt.isUserInteractionEnabled = true
            
        }
//        else if indexPath.row == 5
//        {
//            cell.Invoice_txt.keyboardType = .numberPad
//            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
//            cell.Invoice_txt.text = User_Info?.fax
//
//            cell.Invoice_txt.isUserInteractionEnabled = true
//
//        }
        else if indexPath.row == 5
        {
            cell.Invoice_txt.keyboardType = .emailAddress
            cell.Invoice_Title.text = ((arrRowTitle[indexPath.row] ) as! String)
            cell.Invoice_txt.text = User_Info?.web_address
            cell.Invoice_txt.isUserInteractionEnabled = true
            
        }
        
        if TitleValue != "Edit Profile"
        {
            cell.Invoice_txt.isUserInteractionEnabled = false
        }
        
        
        cell.Invoice_txt.tag = indexPath.row
        cell.Invoice_Title.textColor = UIColor.black
        cell.Invoice_txt.delegate = self
        cell.selectionStyle = .none
        
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            
            if  indexPath.row == 3
            {
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "ProfileAddress") as! ProfileAddress
                self.navigationController?.pushViewController(EditProfileViewController, animated: true)
            }
            
        }
        
    }
    
    
    func ShowDropDownImage(Image: Ionicons) -> UIImageView {
        
        
        let imageView = UIImageView()
        imageView.frame  = CGRect(x: 20, y: 40, width: 30, height: 30)
        imageView.image = UIImage.ionicon(with: Image, textColor: UIColor.black, size: CGSize(width: 50, height: 50))
        
        return imageView
        
    }
    
    func HideDropDownImage() -> UIImageView {
        
        
        let imageView = UIImageView()
        imageView.frame  = CGRect(x: 20, y: 20, width: 1, height: 1)
        imageView.image = UIImage.ionicon(with: .iosArrowDown, textColor: .clear, size: CGSize(width: 1, height: 1))
        
        return imageView
        
    }
    
    
}


// MARK: - Image Picker Controller Delegate Methods


extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // imgUserPic.contentMode = .scaleAspectFit
        imgUserPic.image = chosenImage
        
        
        let image = chosenImage.pngData() as NSData?

        
        imgUserPic.layer.cornerRadius = 75
        imgUserPic.clipsToBounds = true
        
        dismissPicker(picker: picker)
        
        
        // Check Get Tax List
       
     //   UpdateProfilePic(param: image! as Data)
        
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissPicker(picker: picker)
    }
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
    }
    private func dismissPicker(picker : UIImagePickerController){
        picker.view!.removeFromSuperview()
        picker.removeFromParent()
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        UIApplication.shared.isStatusBarHidden = false
    }
}





// MARK: - TextField Delegate Methods


extension EditProfileVC : UITextFieldDelegate
{
    // datepickerView
    
    func pickUpDate(_ textField : UITextField){
        
        print("TagValue:----->>>",textField.tag)
        
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        print("shouldChangeCharactersIn :---",textField.tag)
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
       
         if textField.tag == 1
            
        {
          
            User_Info!.user_name = newString as String
         
        }
        else if textField.tag == 2
        {
            User_Info?.company_name = newString as String
         
        }
       
        else if textField.tag == 4
        {
             User_Info?.phone_no  = newString as String
        }
//        else if textField.tag == 5
//        {
//          User_Info?.fax = newString as String
//
//        }
        else if textField.tag == 5
        {
           User_Info?.web_address = newString as String
            
        }
        
        
        return true
    }
    
}

extension EditProfileVC: EmptyStateDelegate {
    
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
            
            GetUserProfile(param: [:],isLoader:true)
            view.emptyState.hide()
            
        }
        
    }
    
}
