
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
class DefaultAddress: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    
    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var ClassType: String = ""
    var User_Info : ShowUserAddressObject?

    
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
        
        
        
        //setup Section Headerview text and invoice placeholder text
        
        arrSctionTitle = [""]
        arrInvoicetitle = ["Address Line 1","Address Line 2","Country","State","City","Postal Code"]
      
        
        
        RightActionButton(Title: "Save")
        
        self.title = "Default Address"
        
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
        
        
    }
    
    ///// Cancel Button Action
    
    @objc func LeftButtonAction(){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - createPickerView
    
    func createPickerView(){
        
        
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
        
        self.view .endEditing(true)
        
        
    }
    
    // MARK: - Toolbar Cancel Button Click Method
    
    @objc func cancelClick() {
        
        
        self.view .endEditing(true)
        
    }
    
    
//    // MARK: - Get Tax List API Request
//    
//    func GetUserAddress(param : [String : Any],isLoader:Bool){
//        self.view.endEditing(true)
//        
//        
//        ShowUserAddressAPIRequest.shared.ShowUserAddress(requestParams: param) { (obj, msg, success,session) in
//            
//            
//            if session == true
//            {
//                if success == false {
//                    self.MessageAlert(title: "", message: msg!)
//                    
//                }
//                else
//                {
//                    
//                    self.User_Info = obj
//                    
//                   
//                  
//                    
//                    self.tableVw.reloadData()
//                    
//                    
//                }
//            }
//            else{
//                
//                self.SessionMessageAlert(title:"Invoicing", message: msg!)
//                
//            }
//            
//        }
//        
//        
//        
//        
//    }
//    
//    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension DefaultAddress : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
        }
        
        
        
    }
    
    


// MARK: - Table View Delegate/DataSource Methods

extension DefaultAddress : UITableViewDelegate,UITableViewDataSource
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
                self.pickUpDate(cell.Invoice_txt)
                cell.Invoice_txt.text = User_Info?.address1

                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_txt.keyboardType = .numberPad
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)
                cell.Invoice_txt.text = User_Info?.address2

             
            }
          
            else if indexPath.row == 2
            {
                cell.Invoice_txt.text = User_Info?.country_name

        }
            else if indexPath.row == 3
            {
               
                cell.Invoice_txt.text = User_Info?.state_name

        }
            else if indexPath.row == 4
            {
                cell.Invoice_txt.text = User_Info?.city

                
        }
            else if indexPath.row == 5
            {
                cell.Invoice_txt.text = User_Info?.postalcode
                
                
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



extension DefaultAddress: EmptyStateDelegate {
    
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
            
           // GetUserAddress(param: [:],isLoader:true)

            view.emptyState.hide()
            
        }
        
    }
    
}
