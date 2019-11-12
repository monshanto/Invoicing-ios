

import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
class CreateVendor: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    
    var arrSctionTitle = [String]()
    
    var arrSctionTitle1 = [String]()
    var arrSctionTitle2 = [String]()
    var arrSctionTitle3 = [String]()
    var arrSctionTitle4 = [String]()
    
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
        
        
        
        arrSctionTitle = ["","CUSTOMER NAME","PHONE","OTHER INFO"]
        arrSctionTitle1 = ["Customer","Email"]
        arrSctionTitle2 = ["First name","Last name"]
        arrSctionTitle3 = ["Main","Mobile","Toll-free"]
        arrSctionTitle4 = ["Address","Account number","Website"]
        self.title = "New Vendor"
        //setup toolbar and datepicker\data picker
        createPickerView()
        
        RightActionButton(Title: "Save")
        
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

extension CreateVendor : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
    }
    
    
    
}




// MARK: - Table View Delegate/DataSource Methods

extension CreateVendor : UITableViewDelegate,UITableViewDataSource
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
        if section == 0
        {
            return 20
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return arrSctionTitle1.count
            
        }
        else if section == 1
        {
            return arrSctionTitle2.count
            
        }
        else if section == 2
        {
            return arrSctionTitle3.count
            
        }
        else
        {
            return arrSctionTitle4.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
        
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                cell.Invoice_txt.keyboardType = .default

            }
            else
            {
                cell.Invoice_txt.keyboardType = .emailAddress

            }
            cell.Invoice_Title.text = (arrSctionTitle1[indexPath.row] )
            cell.Invoice_txt.placeholder = (arrSctionTitle1[indexPath.row] )
        }
        else if indexPath.section == 1
        {
           
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_Title.text = (arrSctionTitle2[indexPath.row] )
                cell.Invoice_txt.placeholder = (arrSctionTitle2[indexPath.row] )
        }
        else if indexPath.section == 2
        {
            cell.Invoice_txt.keyboardType = .numberPad

            cell.Invoice_Title.text = (arrSctionTitle3[indexPath.row] )
            cell.Invoice_txt.placeholder = (arrSctionTitle3[indexPath.row] )
        }
        else
        {
            if indexPath.row == 0
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

                cell.Invoice_txt.keyboardType = .numberPad
                cell.Invoice_txt.isHidden = true
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.isHidden = false

            }
            else
            {
                cell.Invoice_txt.keyboardType = .default
               cell.Invoice_txt.isHidden = false

            }
            
            cell.Invoice_Title.text = (arrSctionTitle4[indexPath.row] )
            cell.Invoice_txt.placeholder = (arrSctionTitle4[indexPath.row] )
        }
        
        cell.Invoice_Title.textColor = UIColor.black
        cell.Invoice_txt.delegate = self
        cell.Invoice_txt.tag = indexPath.row
        
        cell.selectionStyle = .none
        
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3
        {
            if indexPath.row == 0
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "DefaultAddress") as! DefaultAddress
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else  if indexPath.row == 1
            {
                
                
            }
            else
            {
                
                
                
            }
            
        }
    }
    
   
}




extension CreateVendor: EmptyStateDelegate {
    
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
