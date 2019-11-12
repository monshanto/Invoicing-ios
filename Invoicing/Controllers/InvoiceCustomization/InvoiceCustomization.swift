
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire

class InvoiceCustomization: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    
    var arrInvoicetitleSectionOne = [String]()
    var arrInvoicetitleSectionTwo = [String]()
    var arrInvoicetitleSectionThree = [String]()

    
    
    
    var arrInvoicetitlePlaceholding = [String]()
    
    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var ClassType: String = ""
    let imagePicker = UIImagePickerController()

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        
    }
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.alwaysBounceVertical = false
        tableVw.alwaysBounceHorizontal = false
        tableVw.tableFooterView = UIView()
        
        arrSctionTitle = ["INVOICE STYLE","BUSINESS INFO","COLUMN TITLES","COLUMN DISPLAY"]
        arrInvoicetitleSectionOne = ["Name","Address","Contact"]
           arrInvoicetitleSectionTwo = ["Items","Units","Price","Amount"]
          arrInvoicetitleSectionThree = ["Name","Hide Units","Hide Price","Hide Amount"]
       
        arrCurrencytitle = ["USD","CAD","EUR","AED","AFN","AUD","HNL","ILS","INR"]
        RightActionButton(Title: "Done")
        self.title = "Customize Invoice"

        
        //setup toolbar and datepicker\data picker
        createPickerView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
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
        dismiss(animated: true, completion: nil)
        
        
    }
    
    ///// Cancel Button Action
    
    @objc func LeftButtonAction(){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - createPickerView
    
    func createPickerView(){
        
        dataPickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        dataPickerView.delegate = self
        dataPickerView.dataSource = self
        dataPickerView.backgroundColor = UIColor.white
        dataPickerView.showsSelectionIndicator = true
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
    }
    
    
    
    // MARK: - Date Picker Changed Method
    
    @objc func datePickerChanged(datePicker:UIDatePicker){
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        
        //   Datevalue = dateFormatter.string(from: datePicker.date)
        
        print(dateFormatter.string(from: datePicker.date))
        
    }
    
    
    // MARK: - pickUpDate Method
    
    func pickUpDate(_ textField : UITextField){
        
        print("TagValue:----->>>",textField.tag)
        
        
    }
    
    // MARK: - Toolbar Done Button Click Method
    
    @objc func doneClick() {
        
        self.view .endEditing(true)
        
        
    }
    
    // MARK: - Toolbar Cancel Button Click Method
    
    @objc func cancelClick() {
        
        
        self.view .endEditing(true)
        
    }
    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension InvoiceCustomization : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField.tag == 200
        {
            DispatchQueue.main.async {
                textField.resignFirstResponder()

            }
            self.DueDayOption()

        }
       
        else
        {
            textField.inputView = nil
            textField.inputAccessoryView = nil
        }
        
        
        
        
    }
    
    
    // MARK: - DueDay Multiple section Option
    
    @objc func DueDayOption(){
        
        self.popupAlertWithSheet(title: "DESCRIPTION", message: nil, actionTitles: [ "Show Both","Hide Name", "Hide Description", ], actions:[
            {action1 in
                
                
                
            },{action2 in
                
                
                
                
            },{action3 in
                
                
                
                
            }, nil])
        
        
    }
    
    
    
    
}

// MARK: - Table View Delegate/DataSource Methods

extension InvoiceCustomization : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSctionTitle.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = (arrSctionTitle[section] )
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.darkGray
        headerView.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1.0)
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 4
        }
            
        else if section == 1
        {
            return arrInvoicetitleSectionOne.count
            
        }
        else if section == 2
        {
            return arrInvoicetitleSectionTwo.count

        }
       
        else
        {
            return arrInvoicetitleSectionThree.count

        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
            
            
            
            if indexPath.row == 0
            {
                cell.imgUser?.image = UIImage(named: "Invoice")
                cell.imgUser?.backgroundColor = UIColor.clear
                cell.lblUserName.text = "Invoice Template"
                cell.lblemailid.text = "Classic"
            }
            else if indexPath.row == 1
            {
                cell.imgUser?.image = UIImage(named: "Invoice")
                cell.imgUser?.backgroundColor = UIColor.clear
                
                cell.lblUserName.text = "Receipt Template"
                cell.lblemailid.text = "Classic"
            }
            else if indexPath.row == 2
            {
                
                cell.imgUser?.image = UIImage(named: "Invoice")
                cell.imgUser?.backgroundColor = UIColor.clear
                
                cell.lblUserName.text = "Debt Letter Template"
                cell.lblemailid.text = "Classic"
            }
            else if indexPath.row == 3
            {
                cell.imgUser?.image = UIImage(named: "AppIcon")
                cell.imgUser?.backgroundColor = UIColor.clear
                
                cell.lblUserName.text = "Company Letter Template"
                cell.lblemailid.text = "Select an image"
            }
                
            else
            {
                cell.imgUser?.backgroundColor = UIColor.blue
                
                cell.lblUserName.text = "Accent color"
                cell.lblemailid.text = "#FFFF0040"
            }
            
            
            cell.lblUserName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.lblemailid.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            
            
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.Invoice_txt.delegate = self
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.textColor = UIColor.black
            cell.Invoice_txt.tag = indexPath.row
            cell.Invoice_Title.text = (arrInvoicetitleSectionOne[indexPath.row] )
            cell.selectionStyle = .none
            
            if indexPath.row == 0
            {
                cell.Invoice_txt.keyboardType = .default
               // cell.Invoice_txt.placeholder = (arrInvoicetitleSectionOne[indexPath.row] )
                cell.Invoice_txt.isHidden = false


            }
            else if indexPath.row == 1
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.Invoice_txt.isHidden = true

            }
            else
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.Invoice_txt.isHidden = true



            }
            
            return cell
      }
        else if indexPath.section == 2
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.Invoice_txt.delegate = self
            cell.Invoice_Title.textColor = UIColor.black
            cell.Invoice_txt.tag = indexPath.row
            cell.Invoice_Title.text = (arrInvoicetitleSectionTwo[indexPath.row] )
         //   cell.Invoice_txt.placeholder = (arrInvoicetitleSectionTwo[indexPath.row] )
            cell.selectionStyle = .none
            
            if indexPath.row == 0
            {
                cell.Invoice_txt.keyboardType = .default

            }
            else if indexPath.row == 1
            {
                cell.Invoice_txt.keyboardType = .default

            }
            else if indexPath.row == 2
            {
                cell.Invoice_txt.keyboardType = .decimalPad
                
            }
            else
            {
                cell.Invoice_txt.keyboardType = .decimalPad

            }
            
            return cell
        }
        else
        {
            if indexPath.row == 0
            {
                
            
            
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.Invoice_txt.delegate = self
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.textColor = UIColor.black
            cell.Invoice_txt.tag = 200
            cell.Invoice_Title.text = (arrInvoicetitleSectionThree[indexPath.row] )
                cell.Invoice_txt.placeholder = "Tap To Select"
         //   cell.Invoice_txt.placeholder = (arrInvoicetitleSectionThree[indexPath.row] )
            cell.selectionStyle = .none
            return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
                
                cell.lblTitle.text = (arrInvoicetitleSectionThree[indexPath.row])
                cell.lblTitle.textColor = UIColor.black
                cell.lblTitle.font = UIFont.systemFont(ofSize: 18, weight: .light)
                cell.swSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: UIControl.Event.valueChanged)
                cell.swSwitch.onTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
                cell.swSwitch.isOn = false
                cell.selectionStyle = .none
                return cell
            }
        }
       
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
            if indexPath.row == 3
            {
                ActionSheet()
            }
            else if indexPath.row == 4
            {
                //        let vc = storyboard?.instantiateViewController(withIdentifier: "ColorWheel") as! ColorWheel
                //        self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            else
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "InvoiceSlider") as! InvoiceSlider
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
       else if indexPath.section == 1
        {
         
          if  indexPath.row == 1
          {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "DefaultAddress") as! DefaultAddress
            self.navigationController?.pushViewController(EditProfileViewController, animated: true)
            }
            else if indexPath.row == 2
          {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let EditProfileViewController =  storyboard.instantiateViewController(withIdentifier: "DefaultContact") as! DefaultContact
            self.navigationController?.pushViewController(EditProfileViewController, animated: true)
            }
            
        }
       
    }
    
    // MARK: - Open Action Sheet
    
    
    func ActionSheet()
    {
        
        
        
        self.popupAlertWithSheet(title: "Choose option".uppercased(), message: nil, actionTitles: ["Choose Photo"], actions:[
            {action1 in
                
                self.photoLibrary()
                
            }, nil])
        
        
        
    }
    
    // MARK: - Open Photo Library
    
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    // MARK: - switch Changed
    
    @objc func switchChanged(_ sender: UISwitch) {
        
        let userdefault = UserDefaults.standard
        if sender.isOn
        {
        }
        else
        {
        }
        
        userdefault.synchronize()
        
    }
    
}

// MARK: - PickerView Delegate/DataSource

extension InvoiceCustomization : UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrCurrencytitle.count
        
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (arrCurrencytitle[row] )
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        
        
    }
}

// MARK: - Image Picker Controller Delegate Methods


extension InvoiceCustomization: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        
        
    }
    
    
    
}

extension InvoiceCustomization: EmptyStateDelegate {
    
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
