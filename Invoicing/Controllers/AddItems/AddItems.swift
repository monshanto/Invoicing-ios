//
//  AddItems.swift
//  Invoicing
//
//  Created by MAC on 06/08/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import EmptyStateKit
import Alamofire

class AddItems: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrInvoicetitle = [String]()
    var arrInvoicetitlePlaceholding = [String]()
    var ClassType: String = ""
     var TitleType: String = ""
     var ItemNameValue: String = ""
     var ItemDescriptionValue: String = "Description"
    var ItemPrice: Double = 0.0
    var ItemTax: Double = 0.0
    var ItemQuantity: Int = 1
     var ItemID: Int = 0
    
    
    var ItemInfoDic:[String:Any] = [:]
    var ItemInfoArray:[Any] = []
    var delegate : InvoiceItemProtocolo?
    
    var ItemList : [ItemObject] = []


    override func viewDidLoad() {
        super.viewDidLoad()

      
        // setup tableview
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.alwaysBounceVertical = false
        tableVw.alwaysBounceHorizontal = false
        tableVw.tableFooterView = UIView()

        
        if ClassType == "edit"
        {
             self.title = "Update item"
        
        }
            else  if ClassType == "add"
        {
             self.title = "Item"
        }
        else
        {
            self.title = "New item"
        }
        
        
        arrInvoicetitle = ["Quantity","Price","Tax"]
        
        
        if ClassType == "add"
        {
           RightActionButton(Title: "Add")
        }
        
        else
        {
             RightActionButton(Title: "Save")
        }
        
       

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
        
       if ItemNameValue == ""
       {
        
        self.MessageAlert(title:"Enter Item Name",message:"Please enter a name for this item")
        return
        }
        
        
        if ClassType == "add"
        {
            
           
          
            
                     ItemInfoDic = ["title":ItemNameValue,"_id":ItemID,"description":ItemDescriptionValue,"quantity":ItemQuantity,"total":ItemPrice,"tax":ItemTax]
                      ItemInfoArray.append(ItemInfoDic)
            
            var invoiceItems : [InvoiceItems] = []
            
            
             for item in ItemInfoArray{
                
                ItemInfoArray.append(item)
            }
            
          
            
            print(ItemInfoArray)
            
            
            for item in ItemInfoArray{
                let CustomerItems : InvoiceItems = InvoiceItems.init(model: item as! [String : Any])
                invoiceItems.append(CustomerItems)
            }
            
            self.delegate?.GetItems(Items: invoiceItems)
            
            let controller = self.navigationController?.viewControllers[2]
            self.navigationController?.popToViewController(controller!, animated: true)
            
           // self.navigationController?.popToRootViewController(animated: true)

        }
        else
        {
        
        
        let param = ["name" : ItemNameValue,"description":ItemDescriptionValue,"quantity":ItemQuantity,"price":ItemPrice,"tax":ItemTax,"itemId":ItemID] as [String : Any]
        
        print(param)
        
        if ClassType == "edit"
        {
            self.UpdateItemApi(param: param as [String : Any])
        }
        else
        {
            
            self.CreateItemApi(param: param as [String : Any])
        }
        }
        
    }
    
    
    
    // MARK: - Create Item API Call
    
    func CreateItemApi(param : [String : Any]){
        CreateItemAPIRequest.shared.CreateItem(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    NotificationCenter.default.post(name: Notification.Name("RefreshItemList"), object: nil)
                    
                    
                    
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
    
    func UpdateItemApi(param : [String : Any]){
        UpdateItemAPIRequest.shared.UpdateItem(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    
                    self.popMessageAlert(title:"Invoicing",message: message!)
                    
                    NotificationCenter.default.post(name: Notification.Name("RefreshItemList"), object: nil)
                
                    
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

// MARK: - TextView Delegate/DataSource Methods

extension AddItems : UITextViewDelegate
{
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText newText: String) -> Bool {
        
        ItemDescriptionValue = textView.text
        
        print(ItemDescriptionValue)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        print(textView.text as Any)
        
        return true
    }
    
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
}


// MARK: - TextFeild Delegate/DataSource Methods

extension AddItems : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
       
        
        if textField.tag == 0
        {
            if newString != ""
            {
                ItemQuantity = Int(newString as String)!

            }
            else
            {
                ItemQuantity = 0
            }

        }
        else if textField.tag == 1
        {
            if newString != ""
            {
            let price = Double(newString as String)
            ItemPrice = price!
            }
            else
            {
                ItemPrice = 0.0
            }

        }
        else if textField.tag == 3
        {
            
            
            ItemNameValue = newString as String
        }
       
        
        return true
    }
    
}

// MARK: - Table View Delegate/DataSource Methods

extension AddItems : UITableViewDelegate,UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = ""
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
            return 2
        }
        else if section == 1
        {
            return arrInvoicetitle.count
        }
        else if section == 2
        {
            return 3
        }
        
        else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0
        {
           if indexPath.row == 0
           {
            return 50
            }
            else
           {
            return 100
            }
            
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                 let cell = tableVw.dequeueReusableCell(withIdentifier: "iteamNameCell") as! iteamNameCell
                cell.selectionStyle = .none
                cell.ItemName.delegate = self
                cell.ItemName.tag = 3
                cell.ItemName.text = ItemNameValue

                
                return cell
            }
            else
            {
                 let cell = tableVw.dequeueReusableCell(withIdentifier: "NotesCell") as! NotesCell
                cell.selectionStyle = .none
                cell.Notes_tvt.text = ItemDescriptionValue
                cell.Notes_tvt.delegate = self

                
                return cell
            }
           
            
          
        }
        else if indexPath.section == 1
        {
           let cell = tableVw.dequeueReusableCell(withIdentifier: "InvoiceCell") as! InvoiceCell
            cell.selectionStyle = .none
           
            
           
            
            
            if indexPath.row == 0
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .numberPad
                cell.Invoice_txt.delegate = self
                cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row])
                
                 cell.Invoice_txt.placeholder = "0"
                
                if self.ItemQuantity != 0
                {
                    cell.Invoice_txt.text = "\(self.ItemQuantity)"

                }
                
                
                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .decimalPad
                cell.Invoice_txt.delegate = self
                cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row])
                
                 cell.Invoice_txt.placeholder = "$0.0"
                if self.ItemPrice != 0.0
                {
                cell.Invoice_txt.text = "\(self.ItemPrice)"
                    
                }
                
                
                
            }
            else if indexPath.row == 2
            {
                cell.Invoice_Title.textColor = UIColor.black
                cell.Invoice_txt.keyboardType = .default
                self.view.endEditing(true)
                cell.Invoice_txt.delegate = self
                cell.Invoice_txt.isUserInteractionEnabled = false
                 cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row])
                
                 cell.Invoice_txt.placeholder = "0.0 %"
                if self.ItemTax != 0.0
                {
                 cell.Invoice_txt.text = "\(self.ItemTax) %"
                    
                }
                
                
            }
            cell.Invoice_txt.tag = indexPath.row
          
            return cell
        }
       
        else
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
       
        
        
        
    }
    
    
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if indexPath.section == 1
        {
            if indexPath.row == 2
            {
                
                
             ActionSheet()
                
                
            self.view.endEditing(true)
          
            }
            
            
        }
        
    }
    
    
    
    // MARK: - Open Action Sheet
    
    
    func ActionSheet()
    {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "Inclusive", style: .default , handler:{ (UIAlertAction)in
            
            
            self.ItemTax = 10
            self.tableVw.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title:  "Exclusive", style: .default , handler:{ (UIAlertAction)in
            
            self.ItemTax = 0
            self.tableVw.reloadData()

           
        }))
        
        alert.addAction(UIAlertAction(title:"Cancel" , style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
      
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    
    
    
    
}



extension AddItems: EmptyStateDelegate {
    
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
