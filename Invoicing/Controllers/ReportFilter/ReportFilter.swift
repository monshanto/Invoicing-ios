
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire

class ReportFilter: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    var arrInvoicetitlePlaceholding = [String]()
    
    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var ClassType: String = ""
    
    
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
        
        arrSctionTitle = ["Search By Date Tange","Search by Customer","Filter by Status","Search by Time period"]
        arrInvoicetitle = ["Start date","End date"]
        arrInvoicetitlePlaceholding = ["Tap To Select","Tap To Select"]

        
        RightActionButton(Title: "Done")
        LeftActionButton(Title: "Cancel")
        
        self.title = "Statement"
        
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
    
    /////   Cancel Button
    
    func LeftActionButton(Title:String){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
        button.contentVerticalAlignment = .bottom
        button .setTitle(Title, for: .normal)
        button.addTarget(self, action: #selector(LeftButtonAction), for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        var items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.leftBarButtonItems = items
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
    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension ReportFilter : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 0 || textField.tag == 1 {
            
            textField.inputView = self.Date_Picker
            textField.inputAccessoryView = self.toolBar
            Date_Picker.reloadInputViews()
            
            
        }
        else if textField.tag == 11
        {
            self.view .endEditing(true)
            
            self.popupAlertWithSheet(title: nil, message: "Filter".uppercased(), actionTitles: [ "All","Pending","Accepted","Rejected","Draft"], actions:[
                {action1 in
                    
                    
                    
                    
                    
                },{action2 in
                    
                    
                    
                    
                    
                },{action3 in
                    
                    
                    
                    
                    
                },{action4 in
                    
                    
                    
                    
                    
                },{action5 in
                    
                    
                    
                    
                    
                }, nil])
            
        }
        else if textField.tag == 12
        {
            self.view .endEditing(true)
            
            self.popupAlertWithSheet(title: nil, message: "Filter".uppercased(), actionTitles: [ "Invoice","Quotation"], actions:[
                {action1 in
                    
                    
                    
                },{action2 in
                    
                    
                    
                }, nil])
            
        }
        
        
        
    }
    
    
}

// MARK: - Table View Delegate/DataSource Methods

extension ReportFilter : UITableViewDelegate,UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSctionTitle.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = (arrSctionTitle[section] ).uppercased()
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
            return arrInvoicetitle.count
        }
        else  if section == 1
        {
            return 1
        }
        else  if section == 2
        {
            return 2
        }
        else
        {
            return 3
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if indexPath.section == 0
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            
            
            if indexPath.row == 0
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)
                
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .numberPad
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)
                
            }
            
            
            cell.Invoice_txt.tag = indexPath.row
            
            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
            
            cell.Invoice_txt.placeholder = (arrInvoicetitlePlaceholding[indexPath.row] )
            
            cell.selectionStyle = .none
            
            
            return cell
        }
        else  if indexPath.section == 1
        {
            
            
            let cell = tableVw.dequeueReusableCell(withIdentifier: "AddClientCell") as! AddClientCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.selectionStyle = .none
            cell.AddCustomerText.text = "Select Customer"
            cell.AddCustomerText.font = UIFont.systemFont(ofSize: 18, weight: .light)
            cell.AddCustomerText.textColor = UIColor.black

            
            return cell
        }
        else  if indexPath.section == 2
        {
            
            if indexPath.row == 0
            {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.Invoice_txt.tag = 11
            cell.Invoice_Title.text = "Status"
            cell.Invoice_txt.placeholder = "Tap to Select"
            cell.Invoice_txt.delegate = self
            cell.selectionStyle = .none
            return cell
            }
            else
            {
                let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
                cell.Invoice_txt.tag = 12
                cell.Invoice_Title.text = "Category"
                cell.Invoice_txt.placeholder = "Tap to Select"
                cell.Invoice_txt.delegate = self
                cell.selectionStyle = .none
                return cell
            }

            
        }
        else
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.Invoice_txt.isHidden = true
            if indexPath.row == 0
            {
                cell.Invoice_Title.text = "1 week"

            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.text = "1 Month"

            }
            else
            {
                cell.Invoice_Title.text = "1 Year"

            }
            cell.selectionStyle = .none

            
            return cell
        }
        
        
        
        
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


extension ReportFilter: EmptyStateDelegate {
    
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


