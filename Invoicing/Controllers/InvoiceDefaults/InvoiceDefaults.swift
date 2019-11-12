
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire

class InvoiceDefaults: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    
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
        arrInvoicetitle = ["Default Title","Default Subheading","Payment Terms","Currency"]
        arrCurrencytitle = ["USD","CAD","EUR","AED","AFN","AUD","HNL","ILS","INR"]
        RightActionButton(Title: "Done")
        self.title = "Invoice Default"
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

extension InvoiceDefaults : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField.tag == 2
        {
            DispatchQueue.main.async {
                 textField.resignFirstResponder()
                
            }
            self.DueDayOption()

        }
        else if textField.tag == 3
        {
          

            textField.inputView = self.dataPickerView
            textField.inputAccessoryView = self.toolBar
            self.dataPickerView.reloadAllComponents()
        }
        else
        {
            textField.inputView = nil
            textField.inputAccessoryView = nil
        }
        
        
        
        
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

extension InvoiceDefaults : UITableViewDelegate,UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return arrInvoicetitle.count
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
            
            
            
            if indexPath.row == 2
            {
                cell.Invoice_txt.delegate = self
                cell.Invoice_txt.placeholder = "Tap To Select"
                self.pickUpDate(cell.Invoice_txt)
                
            }
            else if indexPath.row == 3
            {
                cell.Invoice_txt.delegate = self
                cell.Invoice_txt.placeholder = "Tap To Select"

                self.pickUpDate(cell.Invoice_txt)

            }
            else
            {
                cell.Invoice_txt.placeholder = "Tap To Enter"

            }
            
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.textColor = UIColor.black
            cell.Invoice_txt.tag = indexPath.row
            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
            
            cell.selectionStyle = .none
            
            
            return cell
        }
        else
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "NotesCell") as! NotesCell
            
            return cell
        }
        
       
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1
        {
            return 100
        }
        else
        {
        return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
}

// MARK: - PickerView Delegate/DataSource

extension InvoiceDefaults : UIPickerViewDelegate,UIPickerViewDataSource
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


extension InvoiceDefaults: EmptyStateDelegate {
    
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
