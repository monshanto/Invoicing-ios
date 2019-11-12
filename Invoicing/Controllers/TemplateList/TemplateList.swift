

import UIKit
import SDWebImage
import SwipeCellKit
import Letters
class TemplateList: UIViewController {
    var resultSearchController = UISearchController()
  
   
    @IBOutlet weak var mtableview: UITableView!
    private let refreshControl = UIRefreshControl()
    fileprivate var FilterString : String = ""
    let imagePicker = UIImagePickerController()

    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Templates"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        // Pull to refress
        refreshControl.addTarget(self, action:  #selector(RefreshScreen), for: .valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            mtableview.refreshControl = refreshControl
        } else {
            mtableview.addSubview(refreshControl)
        }
        
    }
    
    //  Refresh Screen to Table View
    
    @objc func RefreshScreen() {
        
        mtableview.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.mtableview.delegate = self
        self.mtableview.dataSource = self
        self.mtableview.tableFooterView = UIView()
        //  self.mtableview.separatorStyle = .none
        mtableview.rowHeight = UITableView.automaticDimension
        mtableview.estimatedRowHeight = 105
        mtableview.alwaysBounceVertical = false
        mtableview.alwaysBounceHorizontal = false
        
        
//            let btSlider = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(OpenSlider))
//            btSlider.tintColor = UIColor.white
//            navigationItem.leftBarButtonItem = btSlider
        
        RightActionButton(Title: "Update")

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resultSearchController.dismiss(animated: false, completion: nil)
        
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
    
    // MARK: - OpenSlider
    
    @objc func OpenSlider(){
        self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        
    }
    
    // MARK: - create New Contact Action
    @IBAction func createNewContact(_ sender: Any) {
        
                let vc = storyboard?.instantiateViewController(withIdentifier: "CreateContact") as! CreateContact
               self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
   
        
    
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension TemplateList : UISearchBarDelegate
{
    // MARK: - updateSearchResults
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != ""
        {
            FilterString = searchBar.text ?? ""
            
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        FilterString = ""
        
        
    }
    
    
}


// MARK: - Table View Delegate/DataSource Methods

extension TemplateList : UITableViewDelegate,UITableViewDataSource , SwipeTableViewCellDelegate
{
    // MARK: - Table view data source
    
    //1. determine number of rows of cells to show data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamCell
        
    
        
        if indexPath.row == 0
        {
            cell.imgUser?.image = UIImage(named: "Invoice")
             cell.imgUser?.backgroundColor = UIColor.clear
            cell.lblUserName.text = "Invoice Template"
            cell.lblemailid.text = "Classic"
        }
        else if indexPath.row == 1
        {
            cell.imgUser?.image = UIImage(named: "Invoice")
            cell.imgUser?.backgroundColor = UIColor.clear

            cell.lblUserName.text = "Receipt Template"
            cell.lblemailid.text = "Classic"
        }
        else if indexPath.row == 2
        {
           
             cell.imgUser?.image = UIImage(named: "Invoice")
            cell.imgUser?.backgroundColor = UIColor.clear

            cell.lblUserName.text = "Debt Letter Template"
            cell.lblemailid.text = "Classic"
        }
        else if indexPath.row == 3
        {
            cell.imgUser?.image = UIImage(named: "AppIcon")
            cell.imgUser?.backgroundColor = UIColor.clear

            cell.lblUserName.text = "Company Letter Template"
            cell.lblemailid.text = "Select an image"
        }
       
        else
        {
            cell.imgUser?.backgroundColor = UIColor.blue

            cell.lblUserName.text = "Accent color"
            cell.lblemailid.text = "#FFFF0040"
        }
        
        
         cell.lblUserName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
         cell.lblemailid.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // swipe cell for delete and edit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
       
        
        return []
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
      
         if indexPath.row == 3
       {
        ActionSheet()
        }
       else if indexPath.row == 4
       {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ColorWheel") as! ColorWheel
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "InvoiceSlider") as! InvoiceSlider
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

        
    }
    
    
    // MARK: - Open Action Sheet
    
    
    func ActionSheet()
    {
        
       
            
        self.popupAlertWithSheet(title: "Choose option".uppercased(), message: nil, actionTitles: ["Choose Photo"], actions:[
            {action1 in
                
                self.photoLibrary()
                
            }, nil])
    
            
      
    }
    
    
    
    
    
    // MARK: - Open Photo Library
    
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
        
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    
    
    
}


// MARK: - Image Picker Controller Delegate Methods


extension TemplateList: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
    
        
    }
    
    

}


