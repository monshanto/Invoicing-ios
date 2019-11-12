

import UIKit
import SwipeCellKit
import EmptyStateKit
import Alamofire

class Tax: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPlusSign: UILabel!
    @IBOutlet weak var btnView: UIView!
    private let refreshControl = UIRefreshControl()

    var NoDataFound = false
    var Title = "You haven't created any tax"
    var subTitle = "Create your first tax and get paid for your excellent work."
    var Image = ""
    var params :  [String : Any] = [:]
    var TaxList : [TaxObject] = []

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Tax"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        
        //  InterNet Check
        if AlamofireRequest.shared.InterNetConnection()
        {
           
            
            // Check Get Tax List
            params = ["search_text":"","page": 0,"count":GlobalConstants.Count]
            GetTaxList(param: params,isLoader:false)
        }
        else
        {
            // Check InterNet Connection
            CheckInterNetConnection()
        }
        
        
        
    }
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.alwaysBounceVertical = false
        self.tableView.alwaysBounceHorizontal = false
         self.tableView.separatorInset = .zero
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false

        
        btnView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        btnView.createCircleForView()
        lblPlusSign.font = UIFont.ionicon(of: 30)
        lblPlusSign.text = String.ionicon(with: .plus )
        
        let nib = UINib.init(nibName: "NoDataFound", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NoDataFound")
        
        let LoadMorenib = UINib.init(nibName: "LoadMore", bundle: nil)
        self.tableView.register(LoadMorenib, forCellReuseIdentifier: "LoadMore")


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
    }
    
    // MARK: - createTax
    @IBAction func createTax(_ sender: Any) {
        
        SwitchAddTaxView(AddStatus: false,Title:"Add Tax",Tax_id:"",Tax_name: "",Tax_rate: "",Tax_number: "")
        
    }

    
    // MARK: - Call Add/Show Tax Detail Page
    func SwitchAddTaxView(AddStatus:Bool,Title:String,Tax_id:String,Tax_name:String,Tax_rate:String,Tax_number:String)
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let AddTaxObj =  storyboard.instantiateViewController(withIdentifier: "AddTax") as! AddTax
        AddTaxObj.AddStatus = AddStatus
        AddTaxObj.Title = Title
         AddTaxObj.Tax_id = Tax_id
        AddTaxObj.Tax_name = Tax_name
        AddTaxObj.Tax_rate = "\(Tax_rate)"
        AddTaxObj.Tax_number = "\(Tax_number)"

        self.navigationController?.pushViewController(AddTaxObj, animated: true)
    }

    
    // MARK: - Get Tax List API Request

    func GetTaxList(param : [String : Any],isLoader:Bool){
        self.view.endEditing(true)
        
        
        TaxAPIRequest.shared.Tax(requestParams: param,isLoader:isLoader) { (obj, msg, success,session) in
            
            print(obj as Any)
            print(msg as Any)
            print(success)
            print(session)

if session == true
{
            if success == false {
                self.MessageAlert(title: "", message: msg!)

            }
            else
            {
                self.TaxList = obj!
                
                if self.TaxList.count == 0
                {
                    self.NoDataFound = true
                }
                else
                {
                    self.NoDataFound = false

                }
                
                self.tableView.reloadData()


            }
            }
        else{
    
      self.SessionMessageAlert(title:"Invoicing", message: msg!)

            }
            self.refreshControl.endRefreshing()

        }
        

        
        
    }
    
    // MARK: - Delete Tax API Request

    func DeleteTaxApi(param : [String : Any],PathIndex:Int){
        TaxDeleteAPIRequest.shared.TaxDelete(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.TaxList.remove(at: PathIndex)
                    
                    if self.TaxList.count == 0
                    {
                        self.NoDataFound = true
                    }
                    else
                    {
                        self.NoDataFound = false
                        
                    }
                    
                    self.tableView.reloadData()
                 
                    
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
    
    
    func MessageAlertDelete(title:String,message:String,PathIndex:Int,tax_id:String)
    {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Yes" , style: .default, handler:{ (UIAlertAction)in
            
                let param = ["tax_id":tax_id] as [String : Any]
                
                self.DeleteTaxApi(param: param,PathIndex:PathIndex)
         
        }))
        
        alert.addAction(UIAlertAction(title:"No" , style: .cancel, handler:{ (UIAlertAction)in
            
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
}


// MARK: - Table View Delegate/DataSource Methods

extension Tax : UITableViewDelegate , UITableViewDataSource, SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  NoDataFound == false
        {
//            if TaxList.count <  10
//            {
                return TaxList.count

//            }
//            else
//            {
//                return TaxList.count + 1
//
//            }
            
            
        }
        else
        {
            return 1
            
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  NoDataFound == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFound", for: indexPath) as! NoDataFound

            cell.NoDataTitle.text = Title
            cell.NoDataSubTitle.text = subTitle
            
            self.tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        }
        else
        {
      
            
          //  if indexPath.row < TaxList.count{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TaxListCell
                    else{return TaxListCell()}
                cell.delegate = self
            
            let data : TaxObject = self.TaxList[indexPath.row]
            
            print(data)
            cell.selectionStyle = .none
            self.tableView.separatorStyle = .singleLine


            cell.setCellData(Taxes: data)
                return cell

//            }
//            else
//            {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMore", for: indexPath) as! LoadMore
//                cell.selectionStyle = .none
//                return cell
//            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  NoDataFound == true
        {
            return self.tableView.frame.size.height
            
        }
        else
        {
             if indexPath.row < TaxList.count{
                return 70

            }
            else
             {
                return 44

            }
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == TaxList.count - 1 {
            
            
            print("LastCell")
           
            }
        }
    
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
  

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let TaxValue : TaxObject = self.TaxList[indexPath.row]

        
        let deleteAction = SwipeAction(style:.destructive, title:nil) { action, indexPath in
        self.MessageAlertDelete(title: GlobalConstants.Messagetitle, message: "Are You Sure You Want To Delete This Tax", PathIndex: indexPath.row, tax_id: TaxValue.id)
            
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        
        let editAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            self.SwitchAddTaxView(AddStatus: false,Title:"Update Tax",Tax_id:TaxValue.id, Tax_name: TaxValue.name, Tax_rate: "\(TaxValue.taxRate)", Tax_number: "\(TaxValue.taxNumber)")
            
        }
        
        
        
        // customize the action appearance
        
        // deleteAction.backgroundColor =
        deleteAction.image = UIImage.ionicon(with: .androidDelete, textColor: .white, size: CGSize(width: 32, height: 32))
        editAction.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        editAction.image = UIImage.ionicon(with: .edit, textColor: .white, size: CGSize(width: 32, height: 32))
        
        
        return [editAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.transitionStyle = .border
        return options
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let TaxValue : TaxObject = self.TaxList[indexPath.row]
        SwitchAddTaxView(AddStatus: true,Title:"Tax",Tax_id:TaxValue.id, Tax_name: TaxValue.name, Tax_rate: "\(TaxValue.taxRate)", Tax_number: "\(TaxValue.taxNumber)")
        
    }
    
}


extension Tax: EmptyStateDelegate {
    
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
            refreshControl.endRefreshing()

        }
        else
        {
            view.emptyState.hide()
            
            // Check Get Tax List
             params = ["search_text":"","page": 0,"count":GlobalConstants.Count]
            GetTaxList(param: params,isLoader:true)
            
        }
        
    }
    
}

