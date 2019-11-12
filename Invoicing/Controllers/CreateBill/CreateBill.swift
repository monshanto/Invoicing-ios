
import UIKit
import Crashlytics
//import FontAwesome_swift
import SwipeCellKit
import EmptyStateKit
import Alamofire


class CreateBill: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!
    var arrSctionTitle = [String]()
    var arrCurrencytitle = [String]()
    var arrInvoicetitle = [String]()
    var arrInvoicetitlePlaceholding = [String]()
    var Date_Picker = UIDatePicker()
    var dataPickerView = UIPickerView()
    var toolBar = UIToolbar()
    var TypeExpense: Bool = false
    let picker = UIImagePickerController()
    var ImgSaveArray = [String]()
    var ImgArray = [UIImage]()
    var viewController: UIViewController?
    var Title = ""


  //  var imagePickedBlock: ((_ image : UIImage) -> ())?
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
        
        arrSctionTitle = ["EXPENSE DETAILS","ATTACH FILES",""]
        
      
        
        arrInvoicetitle = ["Title","Employee Name","Employee Id","Date","Price"]
        arrInvoicetitlePlaceholding = ["Tap To Enter","Tap To Enter","Tap To Enter","Tap To Select","Tap To Enter"]

        if Title == "Expense"
        {
            
        }
        else
        {
            RightActionButton(Title: "Done")

        }
        
        
        
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
    
    
    // MARK: - Label Line Border
    
    func DashedLineBorder (title: String)-> UILabel {
        
        let ContainerView = UILabel(frame: CGRect(x: 10, y: 10, width: tableVw.frame.size.width-20, height: 55))
        ContainerView.layer.addSublayer(Border(YourLable: ContainerView))
        ContainerView.textAlignment = .center
        ContainerView.font = UIFont.boldSystemFont(ofSize: 16)
        ContainerView.textColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        ContainerView.text = title
        return ContainerView
        
    }
    
}


// MARK: - Lable Border extension

extension CreateBill
{
    func Border(YourLable: UILabel) -> CAShapeLayer{
        
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = YourLable.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: YourLable.bounds).cgPath
        
        
        return yourViewBorder
        
    }
    
}

// MARK: - Table View Delegate/DataSource Methods

extension CreateBill : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            
            textField.inputView = self.Date_Picker
            textField.inputAccessoryView = self.toolBar
            Date_Picker.reloadInputViews()
            
            
        }
       
            
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

extension CreateBill : UITableViewDelegate,UITableViewDataSource,SwipeTableViewCellDelegate
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
        
        if section == 0 || section == 1
        {
            return 50

        }
        else
        {
        return 10
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return arrInvoicetitle.count
        }
        else if section == 1
        {
        return (self.ImgArray.count) + 1
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
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                self.pickUpDate(cell.Invoice_txt)

                
            }
            else if indexPath.row == 1
            {
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
                
                
                
            }
            else if indexPath.row == 2
            {
                cell.Invoice_txt.keyboardType = .numbersAndPunctuation
                cell.Invoice_txt.delegate = self
                
                
                
            }
            else if indexPath.row == 3
            {
                cell.Invoice_txt.keyboardType = .default
                cell.Invoice_txt.delegate = self
               
            }
            else
            {
                cell.Invoice_txt.keyboardType = .decimalPad
                cell.Invoice_txt.delegate = self
            }
           
            
            cell.Invoice_Title.textColor = UIColor.black

            cell.Invoice_txt.tag = indexPath.row
            
            cell.Invoice_Title.text = (arrInvoicetitle[indexPath.row] )
            
            cell.Invoice_txt.placeholder = (arrInvoicetitlePlaceholding[indexPath.row] )
            
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.section == 1
            {
            let myCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            myCell.backgroundColor = UIColor.white
            
            
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            
            if indexPath.row == totalRows - 1 {
                
                myCell.contentView .addSubview(DashedLineBorder(title: "Attached file here"))
            }
                
            else
            {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamCell
                    else
                {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.lblUserName.text = ImgSaveArray[indexPath.row]
                cell.lblemailid.isHidden = true
            //    cell.imgUser.image = UIImage.fontAwesomeIcon(name: .fileImage, style: .regular, textColor: UIColor.blue, size: CGSize(width: 40.0, height: 40.0))
                cell.delegate = self
                return cell
                }
            myCell.selectionStyle = .none
            return myCell
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
                return 75
                
            }
                else if indexPath.section == 2
            {
                return 100
            }
            else
            {
                return UITableView.automaticDimension

            }
            
            
       
       
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        let deleteAction = SwipeAction(style:.destructive, title: nil) { action, indexPath in
            
            
            if indexPath.section == 1
            {
                
                self.ImgArray.remove(at: indexPath.row)
                
            }
            self.tableVw.reloadData()
        }
        
        deleteAction.image = UIImage.ionicon(with: .androidDelete, textColor: .white, size: CGSize(width: 32, height: 32))
        
        return [deleteAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.transitionStyle = .border
        return options
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1
        {
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == totalRows - 1 {
            
            
            self.ActionSheet()
            
        }
        else
        {
            
            guard let controller = ShowImage.instance() else{return}
            controller.img_Var = ImgArray[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        }
        
    }
    
    
    func ActionSheet()
    {
        
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.photoLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
 
    }
    

    
}


// MARK: - ImagePickerController Delegate Methods


extension CreateBill: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            
            
            let alert = UIAlertController(title: "Warning", message: "You don't have camera",         preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            
            self.present(alert, animated: true, completion: nil)
            
           
        }
    }
    func photoLibrary()
    {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    //PickerView Delegate Methods
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            
        }
        
        
        let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        
        ImgArray.append(selectedImage!)
        
        if fileUrl == nil
        {
            ImgSaveArray.append("attachment"+String(format:"%d",ImgArray.count)+String(format:".%@","png"))
        }
        else
        {
            ImgSaveArray.append("attachment"+String(format:"%d",ImgArray.count)+String(format:".%@",fileUrl!.pathExtension))
        }
        
        tableVw.reloadData()
        picker .dismiss(animated: true, completion: nil)

    }
        
    private func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
  

}


extension CreateBill: EmptyStateDelegate {
    
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



