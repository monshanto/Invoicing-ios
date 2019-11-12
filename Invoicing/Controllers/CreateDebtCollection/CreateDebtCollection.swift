
import UIKit
import Crashlytics

class CreateDebtCollection: UIViewController {
    
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
        self.title = "New Debt"
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
        
        arrSctionTitle = ["CUSTOMER DETAILS","DEBT DETAILS",""]
        arrInvoicetitle = ["Subject","Invoice Number","Total Amount","Payment terms"]
        arrInvoicetitlePlaceholding = ["Enter Subject","Enter Invoice Number","$0.00","Enter Payment terms"]
        
        RightActionButton(Title: "Save")
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
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
        
        self.popupAlertWithSheet(title: nil, message: "Send me copy of this letter", actionTitles: [ "Yes","No"], actions:[
            {action1 in
                
                
                
            },{action2 in
                
                
                
                
            }, nil])
    }
    
    
 
 
}


// MARK: - Table View Delegate/DataSource Methods

extension CreateDebtCollection : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            
          
            
        }
        else if textField.tag == 4
        {
            
        }
        else if textField.tag == 5
        {
           
        }
            
        else
        {
           
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

extension CreateDebtCollection : UITableViewDelegate,UITableViewDataSource
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else if section == 1
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
//            let cell = tableVw.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamCell
//            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//            cell.selectionStyle = .none
//
            
            
                        let cell = tableVw.dequeueReusableCell(withIdentifier: "AddClientCell") as! AddClientCell
                        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                        cell.selectionStyle = .none
            cell.AddCustomerText.text = "Select Customer"
            cell.AddCustomerText.font = UIFont.systemFont(ofSize: 18, weight: .light)
            cell.AddCustomerText.textColor = UIColor.black
            
            
            return cell
        }
        
        
       else if indexPath.section == 1
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            
            
            if indexPath.row == 0
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .numbersAndPunctuation
                cell.Invoice_txt.delegate = self
                
                
                
            }
            else if indexPath.row == 2
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .decimalPad
                cell.Invoice_txt.delegate = self
                
                
                
            }
            else if indexPath.row == 3
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                
                
                
                
            }
            else
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                
                
                
            }
            
            
            
            cell.Invoice_txt.tag = indexPath.row
            
            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
            
            cell.Invoice_txt.placeholder = (arrInvoicetitlePlaceholding[indexPath.row] )
            
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
        
        
        if indexPath.section == 2
        {
            return 100
            
        }
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddContact") as! AddContact
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
        
    }
    
    
}
