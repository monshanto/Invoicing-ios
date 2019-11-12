import UIKit
import EmptyStateKit
import Alamofire
class ExpenseList: UIViewController {
    
    @IBOutlet weak var Mtableview: UITableView!
    
    var ExpenseListArray =  [String]()
    var checked = [String]()
    var DataValue = [String]()

    
    var Title_str = ""
    var Selectedindex = 2000
    
    var BackDataBlock: ((_ ExpenseList : [String]) -> ())?

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = Title_str
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        
    }

    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Mtableview.delegate = self
        self.Mtableview.dataSource = self
        self.Mtableview.tableFooterView = UIView()
        
           ExpenseListArray = ["Cost of Goods Sold","Job Costing","Labor","Materials","Bad Debts","Lodging","Postage","Rent Expenses","TDS Payable","Tax Payable"]
        
        self.checked = Array(repeating: "", count:
            ExpenseListArray.count)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        

        
    }
    
  
}

// MARK: - Table View Delegate/DataSource Methods

extension ExpenseList: UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ExpenseListArray.count
            }
    
    
    private func tableView (tableView:UITableView , heightForHeaderInSection section:Int)->Float
    {
        return 20.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenceCell") as! ExpenceCell
       // cell.Title_LBL.font = cus
            
        cell.Title_LBL.textColor = UIColor.black
        cell.Title_LBL.text = ExpenseListArray[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == Selectedindex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        DataValue.append(ExpenseListArray[indexPath.row])
        DataValue.append(String(indexPath.row))

        
        self.BackDataBlock?(DataValue)

        
        Selectedindex = indexPath.row
        self.navigationController?.popViewController(animated: true)
        
        
    }
}


extension ExpenseList: EmptyStateDelegate {
    
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


