
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire

class CreateInvoice: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    var arrInvoicetitlePlaceholding = [String]()

    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var ClassType: String = ""
    var Title: String = ""
 let button = UIButton()
    var items =  [UIBarButtonItem]();
    
    
    var CustomerList : [InvoiceCustomer] = []
    var ItemsList : [InvoiceItems] = []


    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        
        self.title = Title
        
       
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


        //setup toolbar and datepicker\data picker
        createPickerView()

        
        
        //setup Section Headerview text and invoice placeholder text

        arrSctionTitle = ["\(ClassType.uppercased()) DETAILS","CUSTOMER DETAILS","ITEM DETAILS","",""]
        arrInvoicetitle = ["P.O/S.O Number","\(ClassType) Date","Due Date"]
         arrInvoicetitlePlaceholding = ["August 9, 2019","\(ClassType) Number","P.O/S.O Number","August 9, 2019","On Receipt","USD"]
         arrCurrencytitle = ["USD","CAD","EUR","AED","AFN","AUD","HNL","ILS","INR"]
        
        
        print("Title",Title)
        
       
        
        if Title == "Invoice" || Title == "Quotation"
        {
            
        }
        else{
            
            RightActionButton(Title: "Done")
            
        }
        
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        
        print(CustomerList.count)
        
        
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
    }
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }
    
    func CurrentDate()->String
        {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        let result = formatter.string(from: date)
            
      return result

        }
    
    
    
    ///// Add Client / Save Button
    
    func RightActionButton(Title:String){
        
        button.removeFromSuperview()
        button.frame =  CGRect(x: 0, y: 0, width: 70, height: 20)
        button.contentVerticalAlignment = .bottom
        button .setTitle(Title, for: .normal)
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
         items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
    }
    
    ///// Add Client / Save Button Action
    
    @objc func rightButtonAction(){
        
        self.popupAlertWithSheet(title: nil, message: nil, actionTitles: [ "Save as Draft","Send"], actions:[
            {action1 in
                
                
                
            },{action2 in
                
                
                
                
            }, nil])
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
    
    // MARK: - DueDay Multiple section Option

    @objc func DueDayOption(){
        
        self.popupAlertWithSheet(title: nil, message: nil, actionTitles: [ "On receipt","within 15 days", "within 30 days", "within 45 days","within 60 days","within 90 days","Custom"], actions:[
            {action1 in
                
               
                
            },{action2 in
                
              
                
                
            },{action3 in
                
              
                
                
            },{action4 in
                
               
                
                
            },{action5 in
                
            
                
                
            },{action6 in
                
                
                
                
            },{action7 in
                
                
                
                
            }, nil])
    }
    
}


// MARK: - Table View Delegate/DataSource Methods

extension CreateInvoice : UITextFieldDelegate
{

func textFieldDidBeginEditing(_ textField: UITextField) {
    
    if textField.tag == 1 {
        
        textField.inputView = self.Date_Picker
        textField.inputAccessoryView = self.toolBar
        Date_Picker.reloadInputViews()
        
        
    }
    else if textField.tag == 2
    {
        textField.inputView = nil
        textField.inputAccessoryView = nil
        
        DispatchQueue.main.async {
            
            textField.resignFirstResponder()
        }

       DueDayOption()
    }
//    else if textField.tag == 5
//    {
//        textField.inputView = self.dataPickerView
//        textField.inputAccessoryView = self.toolBar
//        self.dataPickerView.reloadAllComponents()
//    }
        
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
    
    print(newString)
    
    
    return true
}
    
}

// MARK: - Table View Delegate/DataSource Methods

extension CreateInvoice : UITableViewDelegate,UITableViewDataSource
{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSctionTitle.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = (arrSctionTitle[section] as! String)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.darkGray
        headerView.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1.0)
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 4
        {
            return 20
        }
        else
        {
        return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return arrInvoicetitle.count
        }
        else if section == 1
        {
            return 1
        }
        else if section == 2
        {
            return ItemsList.count + 1
        }
        else if section == 3
        {
            return 3
        }
        else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        
        if indexPath.section == 0
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            
            
            if indexPath.row == 0
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .numberPad
                cell.Invoice_txt.delegate = self
                cell.Invoice_txt.placeholder = "Tap To Enter"

            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)
                
                cell.Invoice_txt.placeholder = CurrentDate()





            }
            else if indexPath.row == 2
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)

                cell.Invoice_txt.placeholder = "Tap To Enter"




            }
            
            
            cell.Invoice_txt.tag = indexPath.row

            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )

         //   cell.Invoice_txt.placeholder = (arrInvoicetitlePlaceholding[indexPath.row] )
            
            cell.selectionStyle = .none


            return cell
        }
        else if indexPath.section == 1
        {


            if CustomerList.count == 0
            {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "AddClientCell") as! AddClientCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.selectionStyle = .none
            cell.AddCustomerText.text = "Add Customer"
            return cell
                
            }
            else
            {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                            cell.selectionStyle = .none
                let data : InvoiceCustomer = self.CustomerList[indexPath.row]
                cell.setCellData(Customer: data)
                return cell

            }
        }
        else if indexPath.section == 2
        {
            
            if indexPath.row == ItemsList.count
            {
                
                let cell = tableVw.dequeueReusableCell(withIdentifier: "AddClientCell") as! AddClientCell
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.selectionStyle = .none
                cell.AddCustomerText.text = "Add items"
                return cell
            
          
                
            }
            else
            {
                let cell = tableVw.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
                cell.selectionStyle = .none
                let data : InvoiceItems = self.ItemsList[indexPath.row]
                cell.setCellData(InvoiceItems: data)
                return cell
            }
          
        }
        else if indexPath.section == 3
        {
            if indexPath.row == 0
            {
                let cell = tableVw.dequeueReusableCell(withIdentifier: "SubTotalCell") as! SubTotalCell
                cell.selectionStyle = .none

                
                return cell
            }
            
            else if indexPath.row == 1
            {
                let cell = tableVw.dequeueReusableCell(withIdentifier: "TaxesCell") as! TaxesCell
                cell.selectionStyle = .none

                
                return cell
            }
            else
            {
                let cell = tableVw.dequeueReusableCell(withIdentifier: "TotalCell") as! TotalCell
                cell.selectionStyle = .none

                
                return cell
            }
           
        }
        else
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "NotesCell") as! NotesCell
            
            return cell
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 4
        {
            return 100

        }
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddContact") as! AddContact
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
       }
        else if indexPath.section == 2
        {
            let totalRows = tableVw.numberOfRows(inSection: indexPath.section)

            if indexPath.row == totalRows - 1
            {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemList") as! ItemList
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    
}

// MARK: - PickerView Delegate/DataSource

extension CreateInvoice : UIPickerViewDelegate,UIPickerViewDataSource
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



extension CreateInvoice: EmptyStateDelegate {
    
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
            
            self.navigationItem.rightBarButtonItems = nil

        }
        else
        {
            self.navigationItem.rightBarButtonItems = items


           
            view.emptyState.hide()
            
        }
        
    }
    
}



extension CreateInvoice : InvoiceCustomerProtocol
{
    func GetCustomer(Customer: [InvoiceCustomer]) {
        
        CustomerList = Customer
        
        tableVw.reloadData()
        
    }
    
}

extension CreateInvoice : InvoiceItemProtocolo
{
    func GetItems(Items:[InvoiceItems])
    {
        ItemsList = Items
        
        print(ItemsList.count)
        
        tableVw.reloadData()
        
    }
    
    
    
}


