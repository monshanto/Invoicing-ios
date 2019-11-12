

import UIKit
import Crashlytics
import EmptyStateKit
import Alamofire
import GooglePlaces
import GoogleMaps


class CreateContact: UIViewController,CLLocationManagerDelegate {
    
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
    var TitleType: String = ""
    
    var Customer_id: Int = 0
    var Customer: String = ""
    var Email: String = ""
    var FirstName: String = ""
    var LastName: String = ""
    var Main: String = ""
    var Mobile: String = ""
    var Website: String = ""
    var Address: String = "Start Typing In The First Line Of Your Address"

    var CustomerAddress = [String]()




    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        
        if ClassType == "edit"
        {
            self.title = "Update customer"
        }
        else
        {
            self.title = "New customer"
        }
            
        
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
        arrSctionTitle2 = ["First Name","Last Name"]
        arrSctionTitle3 = ["Main","Mobile"]
        arrSctionTitle4 = ["Address","Website"]
        
        if ClassType == "edit"
        {
            RightActionButton(Title: "update")
        }
        else
        {
            RightActionButton(Title: "Save")
        }
        
        
        
        
        
        let LoadMorenib = UINib.init(nibName: "AutoSearchCell", bundle: nil)
        self.tableVw.register(LoadMorenib, forCellReuseIdentifier: "AutoSearchCell")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Call Setup Navigation setting Function
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

        
        
//        if Customer == "" || Customer.trimmingCharacters(in: .whitespaces).isEmpty
//        {
//            self.MessageAlert(title:"",message:"Customer Name Required")
//            return
//        }
        
        if Email == "" || Email.trimmingCharacters(in: .whitespaces).isEmpty
        {
            self.MessageAlert(title:"",message:"Email address required")
            return
        }
        if !(Email.EmailValidation()){
            MessageAlert(title:"",message: "You have entered an invalid email address.")
            return
        }
        
        if FirstName == "" || FirstName.trimmingCharacters(in: .whitespaces).isEmpty
        {
            
            self.MessageAlert(title:"",message:"First name required")
            return
        }
//        if LastName == "" || LastName.trimmingCharacters(in: .whitespaces).isEmpty
//        {
//
//            self.MessageAlert(title:"",message:"Last Name Required")
//            return
//        }
//        if Main == "" || Main.trimmingCharacters(in: .whitespaces).isEmpty
//        {
//
//            self.MessageAlert(title:"",message:"Main Number Required")
//            return
//        }
        if Mobile == "" || Mobile.trimmingCharacters(in: .whitespaces).isEmpty
        {
            
            self.MessageAlert(title:"",message:"Mobile number required")
            return
        }
        if Website == "" || Website.trimmingCharacters(in: .whitespaces).isEmpty
        {
            
            self.MessageAlert(title:"",message:"Website address required")
            return
        }
        
        self.view .endEditing(true)
        
        
        if Address == "Start Typing In The First Line Of Your Address"
        {
            self.MessageAlert(title:"",message:"Address are required")
            return
        }
        
       
        let param = ["bussinessName" : Customer,"personalEmail":Email,"firstName":FirstName,"lastName":LastName,"phone":Main,"mobile":Mobile,"address1":Address,"address2":"","countryId":1,"stateId":5,"city":"","postalcode":"","website":Website,"fax":"","customerId":Customer_id] as [String : Any]
        
        print(param)
        
          if ClassType == "edit"
        {
             self.UpdateCustomerApi(param: param as [String : Any])
        }
        else
          {
            
            self.CreateCustomerApi(param: param as [String : Any])
        }
     
    }
    
    
    func PresentGMSVC()
    {
        let fetcherFilter = GMSAutocompleteFilter()
        
        fetcherFilter.country = "AU"
        
        
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        acController.autocompleteFilter = fetcherFilter
       
//        acController.primaryTextColor = UIColor.white
//        acController.primaryTextHighlightColor = UIColor.white
//        acController.secondaryTextColor = UIColor.white
//        acController.tintColor = UIColor.white
//
//        UINavigationBar.appearance().barTintColor = UIColor.white
//        UINavigationBar.appearance().tintColor = UIColor.white
        
        
       self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = .top
        
       present(acController, animated: true, completion: nil)
        
      //  self.navigationController?.pushViewController(acController, animated: true)
    }
    
    
    
    // MARK: - Create Customer API Call
    
    func CreateCustomerApi(param : [String : Any]){
        CreateCustomerAPIRequest.shared.CreateCustomer(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    NotificationCenter.default.post(name: Notification.Name("RefreshCustomerList"), object: nil)

                    
                    
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
    
    
    // MARK: - Update Customer API Call
    
    func UpdateCustomerApi(param : [String : Any]){
        UpdateCustomerAPIRequest.shared.UpdateCustomer(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    NotificationCenter.default.post(name: Notification.Name("RefreshView"), object: nil)
                    
                    
                    
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

extension CreateContact : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        print(newString)
        
        if textField.tag == 0
        {
            Customer = newString as String
        }
        else if textField.tag == 1
        {
            
            
            Email = newString as String
        }
        else if textField.tag == 2
        {
            
            
            FirstName = newString as String
        }
        else if textField.tag == 3
        {
            
            
            LastName = newString as String
        }
        else if textField.tag == 4
        {
            
            
            Main = newString as String
        }
        else if textField.tag == 5
        {
            
            
            Mobile = newString as String
        }
        else if textField.tag == 6
        {
            
            
        }
        else if textField.tag == 7
        {
            
            
            Website = newString as String
        }
        
        return true
    }
    
}




// MARK: - Table View Delegate/DataSource Methods

extension CreateContact : UITableViewDelegate,UITableViewDataSource
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
                cell.Invoice_txt.text = Customer
                
            }
            else
            {
                cell.Invoice_txt.keyboardType = .emailAddress
                cell.Invoice_txt.text = Email

                
            }
            cell.Invoice_Title.text = (arrSctionTitle1[indexPath.row] )
           // cell.Invoice_txt.placeholder = (arrSctionTitle1[indexPath.row] )
            
          cell.Invoice_txt.tag = indexPath.row
            
        }
        else if indexPath.section == 1
        {
            
            cell.Invoice_txt.keyboardType = .default
            cell.Invoice_Title.text = (arrSctionTitle2[indexPath.row] )
            
            if indexPath.row == 0
            {
                cell.Invoice_txt.text = FirstName

            }
            else
            {
                cell.Invoice_txt.text = LastName

            }
            
            cell.Invoice_txt.tag = indexPath.row + 2
        }
        else if indexPath.section == 2
        {
            cell.Invoice_txt.keyboardType = .numberPad
            
            cell.Invoice_Title.text = (arrSctionTitle3[indexPath.row] )
            
            if indexPath.row == 0
            {
                cell.Invoice_txt.text = Main
                
            }
            else
            {
                cell.Invoice_txt.text = Mobile
                
            }
            
            cell.Invoice_txt.tag = indexPath.row + 4
        }
        else
        {
            cell.Invoice_txt.tag = indexPath.row + 6

            
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AutoSearchCell", for: indexPath) as! AutoSearchCell
                               cell.selectionStyle = .none
                cell.Address_SubTitle.text = Address
                return cell
                
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.isHidden = false
                
                cell.Invoice_txt.text = Website

                
            }
          
            cell.Invoice_Title.text = (arrSctionTitle4[indexPath.row] )
        }
        
        cell.Invoice_Title.textColor = UIColor.black
        cell.Invoice_txt.delegate = self
        
        cell.selectionStyle = .none
        
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 3
        {
            if indexPath.row == 0
            {
                return 55

            }
            else
            {
                return UITableView.automaticDimension

            }
        }
        else
        {
        
        return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3
        {
        if indexPath.row == 0
        {
            
            PresentGMSVC()

            
//            let vc = storyboard?.instantiateViewController(withIdentifier: "DefaultAddress") as! DefaultAddress
//            self.navigationController?.pushViewController(vc, animated: true)
            
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


extension CreateContact : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("I'm scrolling!")

        
    }
}


extension CreateContact: EmptyStateDelegate {
    
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


// MARK: - Autocomplete Methods


extension CreateContact: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
    
        self.geoAddress(lat: place.coordinate.latitude, long:  place.coordinate.longitude)
        print("Latitude :- \(place.coordinate.latitude)")
        print("Longitude :- \(place.coordinate.longitude)")
        
        dismissAutoComplete(picker: viewController)
        // Dismiss the GMSAutocompleteViewController when something is selected
        
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismissAutoComplete(picker: viewController)

    }
    
    private func dismissAutoComplete(picker : GMSAutocompleteViewController){
        dismiss(animated: true, completion: nil)

       
    }
    
    
    
    func geoAddress(lat : Double , long : Double)
    {
        let geocoder = GMSGeocoder()
        
        let coordinate = CLLocationCoordinate2DMake(lat, long)
        
        print(coordinate)
        var currentAddress = String()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                guard let lines = address.lines as? [String] else{return}
               self.Address = lines.joined(separator: ",")
                
                
                print("Address", self.Address)

                
                self.tableVw.reloadData()
                
                print(currentAddress)
             //   self.AddressWithLongitude(long, andLatitude: lat, andTitle: currentAddress)
                //currentAddress = lines.joinWithSeparator("\n")
                
                //currentAdd(returnAddress: currentAddress)
            }
        }
    }
    
    
}
