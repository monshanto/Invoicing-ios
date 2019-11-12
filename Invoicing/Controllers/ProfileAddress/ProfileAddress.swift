
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
class ProfileAddress: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrPlaceHoldingData = [String]()
    var arrCountryData = [String]()
    var arrStateData = [String]()

    var arrInvoicetitle = [String]()
    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var ClassType: String = ""
    var User_Info : ShowUserAddressObject?
    var params :  [String : Any] = [:]
    var SelectedIndex = 0
    var SelectedRow = 0

    
    
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
        
        
        
         arrCountryData = ["Australia"]
         arrStateData =  ["New South Wales", "Western Australia", "Queensland", "South Australia", "Victoria", "Tasmania"]
        
        
        //setup Section Headerview text and invoice placeholder text
        
        arrSctionTitle = [""]
        arrInvoicetitle = ["Address Line 1","Address Line 2","Country","State","City","Postal Code"]
        
        
        
        RightActionButton(Title: "Save")
        
        self.title = "Address"
        
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
    
    
    ///// Save Button Action
    
    @objc func rightButtonAction(){
       

        
        // Check Get Tax List
        params = ["address1":User_Info!.address1,"address2":User_Info!.address2,"countryId":User_Info!.countryId,"stateId":User_Info!.stateId,"city":User_Info!.city,"postalcode":User_Info!.postalcode]
        UpdateUserAddress(param: params,isLoader:true)
        
    }
    
  
    
    // MARK: - createPickerView
    
    func createPickerView(){
        
        
        dataPickerView.delegate = self
        
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
        
        
        Date_Picker.datePickerMode = UIDatePicker.Mode.date
        Date_Picker.addTarget(self, action: #selector(datePickerChanged), for: UIControl.Event.valueChanged)
        
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
        
        
        if SelectedIndex == 2
        {
            User_Info!.countryId = 1
             User_Info?.country_name = arrCountryData[SelectedRow]
            
            User_Info!.stateId = 0
            User_Info?.state_name = ""
            
        }
        else
        {
            
            if SelectedRow == 0
            {
                 User_Info!.stateId = 1
                User_Info?.state_name = arrStateData[0]
            }
            else
            {
                 User_Info!.stateId = SelectedRow + 3
                 User_Info?.state_name = arrStateData[SelectedRow]
            }
            
           
        }
        
        self.dataPickerView.reloadAllComponents()
        self.dataPickerView.selectRow(0, inComponent: 0, animated: true)

        SelectedRow = 0
        tableVw.reloadData()
        
        self.view .endEditing(true)
        
        
    }
    
    // MARK: - Toolbar Cancel Button Click Method
    
    @objc func cancelClick() {
        
        self.dataPickerView.selectRow(0, inComponent: 0, animated: true)

        self.dataPickerView.reloadAllComponents()
        SelectedRow = 0
        self.view .endEditing(true)
        
    }
    
    
    // MARK: - Get User Address API Request
    
    func GetUserAddress(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        ShowUserAddressAPIRequest.shared.ShowUserAddress(requestParams: param) { (obj, msg, success,session) in
            
            
            if session == true
            {
 
                
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                }
                else
                {
                    
                    self.User_Info = obj
     
                    
                    self.tableVw.reloadData()
                    
                    
                }
            }
            else{
                
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
        
    }
    
    // MARK: - GetCountriesList
    
    func GetCountriesList(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        CountriesListAPIRequest.shared.CountriesList(requestParams: param) { ( msg, success,session,Data) in
            
            
            
            if (Data["countriesList"] as? [String : Any]) != nil{
                
                // print(result["name"] as! [String])
                
                
               //  print((result[1] as! [String:Any])["name"] as! String)
                
            }
            
  
                  
            }
    
        
    }

    
    // MARK: - Update User Information API Request
    
    func UpdateUserAddress(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        EditAddressAPIRequest.shared.EditAddress(requestParams: param) { (msg, success,session) in
            
            
            if session == true
            {
                if success == false {
                    self.MessageAlert(title: "", message: msg!)
                    
                }
                else
                {
                    
                    self.MessageAlert(title: "", message: msg!)
                    
                    
                }
            }
            else{
                
                self.SessionMessageAlert(title:"Invoicing", message: msg!)
                
            }
            
        }
        
        
    }

    
}


// MARK: - Table View Delegate/DataSource Methods

extension ProfileAddress : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        SelectedIndex = textField.tag
        
        if textField.tag == 2
        {
        
            arrPlaceHoldingData = arrCountryData

            textField.inputView = self.dataPickerView
            textField.inputAccessoryView = self.toolBar
            self.dataPickerView.reloadAllComponents()
        }
            else if textField.tag == 3
        {
            
            
          if  User_Info!.countryId == 0
          {
         self.MessageAlert(title: "", message: "Please select county first")
            
            }
            else
       {
        arrPlaceHoldingData = arrStateData
        
        textField.inputView = self.dataPickerView
        textField.inputAccessoryView = self.toolBar
        self.dataPickerView.reloadAllComponents()
        
            }
           
        }
        else
        {
            textField.inputView = nil
            textField.inputAccessoryView = nil
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        print("shouldChangeCharactersIn :---",textField.tag)
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        
        if textField.tag == 0
        {
         User_Info!.address1 = newString as String
            
        }
        else if textField.tag == 1
        {
            User_Info!.address2 = newString as String
        }
        else if textField.tag == 4
        {
            User_Info!.city = newString as String
        }
        else if textField.tag == 5
        {
            User_Info!.postalcode = newString as String
        }
        
        return true
    
    }
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension ProfileAddress : UITableViewDelegate,UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0
        //        {
        return arrInvoicetitle.count
        //        }
        //        else  if section == 1
        //        {
        //            return 1
        //        }
        //        else  if section == 2
        //        {
        //            return 1
        //        }
        //        else
        //        {
        //            return 3
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
        
        cell.Invoice_txt.placeholder = "Tap to Enter"
        
        if indexPath.row == 0
        {
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_txt.delegate = self
            cell.Invoice_txt.text = User_Info?.address1
            
        }
        else if indexPath.row == 1
        {
            cell.Invoice_txt.keyboardType = .numberPad
            cell.Invoice_txt.delegate = self
            cell.Invoice_txt.text = User_Info?.address2
            
        }
            
        else if indexPath.row == 2
        {
            cell.Invoice_txt.delegate = self

            self.pickUpDate(cell.Invoice_txt)

            cell.Invoice_txt.text = User_Info?.country_name
            
        }
        else if indexPath.row == 3
        {
            cell.Invoice_txt.delegate = self

            self.pickUpDate(cell.Invoice_txt)

            cell.Invoice_txt.text = User_Info?.state_name
            
        }
        else if indexPath.row == 4
        {
            cell.Invoice_txt.delegate = self

            cell.Invoice_txt.text = User_Info?.city
            
        }
        else if indexPath.row == 5
        {
            cell.Invoice_txt.delegate = self

            cell.Invoice_txt.text = User_Info?.postalcode
            cell.Invoice_txt.keyboardType = .numberPad
            
            
        }
        
        cell.Invoice_Title.textColor = UIColor.black
        
        cell.Invoice_txt.tag = indexPath.row
        
        cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
        
        
        cell.selectionStyle = .none
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
            
        }
        else  if indexPath.section == 1
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddContact") as! AddContact
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexPath.section == 2
        {
            
            
        }
        else if indexPath.section == 3
        {
            
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
}
// MARK: - PickerView Delegate/DataSource

extension ProfileAddress : UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrPlaceHoldingData.count
        
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPlaceHoldingData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        SelectedRow = row
        
    }
}

extension ProfileAddress: EmptyStateDelegate {
    
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
            GetUserAddress(param: [:],isLoader:true)
            view.emptyState.hide()
        }
        
    }
    
}

