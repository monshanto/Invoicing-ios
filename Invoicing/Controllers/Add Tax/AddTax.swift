


import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
class AddTax: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    
    var toolBar = UIToolbar()
    var ClassType: String = ""
    var AddStatus: Bool = false
    var Tax_name: String = ""
    var Tax_rate: String = ""
    var Tax_number: String = ""
      var Tax_id: String = ""
    var Title: String = ""



    
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
        tableVw.isUserInteractionEnabled = false

        tableVw.tableFooterView = UIView()
        
        
        if AddStatus == false
        {
            RightActionButton(Title: "Save")
            tableVw.isUserInteractionEnabled = true


        }
       
        
        self.title = Title

        //setup Section Headerview text and invoice placeholder text
        
        arrSctionTitle = ["Tax Name","Tax Rate","Tax Number/ID"]
        
        
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
        
        
      
        
        if Tax_name == ""
        {
            self.MessageAlert(title:"",message:"Tax Name Required")
            return
        }
        
        if Tax_rate == "" || Tax_rate == "0"
        {
            self.MessageAlert(title:"",message:"Tax Rate Required")
            return
        }
        
        if Tax_number == "" || Tax_number == "0"
        {
            
            self.MessageAlert(title:"",message:"Tax Number Required")
            return
        }
        
        self.view .endEditing(true)
        
        if Title == "Update Tax"
        {
            let param = ["tax_id":Tax_id,"name" : Tax_name,"tax_rate":Tax_rate,"tax_number":Tax_number] as [String : Any]
            
            print(param)
            self.UpdateTaxApi(param: param as [String : Any])
        }
        else
        {
            let param = ["name" : Tax_name,"tax_rate":Tax_rate,"tax_number":Tax_number] as [String : Any]
            
            print(param)
            self.CreateTaxApi(param: param as [String : Any])
        }
        
       
        
        
    }
    
  
    // MARK: - Create Tax API Call

    func CreateTaxApi(param : [String : Any]){
        CreateTaxRequest.shared.CreateTax(requestParams: param) { (message, status,session) in
            
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
    
    // MARK: - Update Tax API Call

    func UpdateTaxApi(param : [String : Any]){
        UpdateTaxRequest.shared.UpdateTax(requestParams: param) { (message, status,session) in
            
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

extension AddTax : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSctionTitle.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
        
        
        if indexPath.row == 1
        {
            cell.Invoice_txt.keyboardType = .decimalPad
            
            
        }
            else if indexPath.row == 2
        {
            
            cell.Invoice_txt.keyboardType = .numberPad

        }
        else
        {
            cell.Invoice_txt.keyboardType = .default
            
        }
        
        
        
        cell.Invoice_Title.textColor = UIColor.black
        cell.Invoice_txt.delegate = self
        cell.Invoice_txt.tag = indexPath.row
        cell.Invoice_Title.text = (arrSctionTitle[indexPath.row] )
        
        if indexPath.row == 0
        {
        cell.Invoice_txt.text = Tax_name
        }
        else if indexPath.row == 1
        {
            cell.Invoice_txt.text = Tax_rate

        }
        else
        {
            cell.Invoice_txt.text = Tax_number

        }
        
        cell.selectionStyle = .none
        
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
    
}


extension AddTax: EmptyStateDelegate {
    
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


// MARK: - TextFeild Delegate/DataSource Methods

extension AddTax : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        print(newString)
        
        
        if textField.tag == 0
        {
            Tax_name = newString as String
                    }
        else if textField.tag == 1
        {
            
            
            Tax_rate = newString as String
        }
        else
        {
            Tax_number = newString as String

        }
        
        
        return true
    }
}
