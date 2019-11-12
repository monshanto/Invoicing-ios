
import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
class VendorDetails: UIViewController {
    
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
        self.title = "Invoice"
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
        
        arrSctionTitle = ["VENDOR DETAILS","INVOICE DETAILS","ITEM DETAILS","",""]
        arrInvoicetitle = ["\(ClassType) title","\(ClassType) number","P.O/S.O number","\(ClassType) date","Due date","Currency"]
        arrInvoicetitlePlaceholding = ["August 9, 2019","\(ClassType) number","P.O/S.O number","August 9, 2019","On receipt","USD"]
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()

        
    }
    
    
   
   
    
    
   
    
    
}



// MARK: - Table View Delegate/DataSource Methods

extension VendorDetails : UITableViewDelegate,UITableViewDataSource
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
        else if section == 2
        {
            return 2
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
        
        
        
        
        if indexPath.section == 1
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            
            
            if indexPath.row == 0
            {
                cell.Invoice_Title.textColor = UIColor.black
               
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.textColor = UIColor.black
                
                
                
                
            }
            else if indexPath.row == 2
            {
                cell.Invoice_Title.textColor = UIColor.black
               
                
                
                
            }
            else if indexPath.row == 3
            {
                cell.Invoice_Title.textColor = UIColor.black
                
                
            }
            else if indexPath.row == 4
            {
                cell.Invoice_Title.textColor = UIColor.black
               
                
            }
            else
            {
                cell.Invoice_Title.textColor = UIColor.black
              
            }
            
            cell.Invoice_txt.isUserInteractionEnabled = false
            cell.Invoice_txt.tag = indexPath.row
            
            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
            
            cell.Invoice_txt.placeholder = (arrInvoicetitlePlaceholding[indexPath.row] )
            
            cell.selectionStyle = .none
            
            
            return cell
        }
        else if indexPath.section == 0
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamCell
            cell.selectionStyle = .none
            
         
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableVw.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
            cell.selectionStyle = .none
            
            return cell
            
           
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
            
            cell.Notes_tvt.isUserInteractionEnabled = false
            cell.selectionStyle = .none

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
        
        
       
        
    }
    
    
}

extension VendorDetails: EmptyStateDelegate {
    
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


