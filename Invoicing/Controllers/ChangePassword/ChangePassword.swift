

import UIKit
import EmptyStateKit
import Alamofire

class ChangePassword: UIViewController {
    
    @IBOutlet weak var lblOldPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    // MARK: - Setup Navigation bar

    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
          self.title = "Change Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
    }
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOldPassword.Padding()
        txtOldPassword.textFieldBottomBorder()
        txtOldPassword.backgroundColor = UIColor.clear
        txtOldPassword.delegate = self
        
        txtNewPassword.Padding()
        txtNewPassword.textFieldBottomBorder()
        txtNewPassword.backgroundColor = UIColor.clear
        txtNewPassword.delegate = self
        
        txtConfirmPassword.Padding()
        txtConfirmPassword.textFieldBottomBorder()
        txtConfirmPassword.backgroundColor = UIColor.clear
        txtConfirmPassword.delegate = self
        
        
        btnDone.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
        lblOldPassword.text = "Enter Old Password"
        lblNewPassword.text =  "Enter New Password"
        lblConfirmPassword.text =  "Confirm New Password"
        
         PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
    }
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }
  
    
    // MARK: - Done Button Action
    
    @IBAction func DoneAction(_ sender: Any) {
        
        guard let NewPassword = txtNewPassword.text,let ConfirmPassword = txtConfirmPassword.text else{return}
        
        if txtOldPassword.text == ""
        {
            self.MessageAlert(title:"",message:"Please enter your old password")
            return
        }
            
        if  !txtNewPassword.PasswordValidation()
        {
            
            self.MessageAlert(title:"",message:"Please ensure that you have at least 8 characters, including at least 1 letter and 1 digit")
            return
        }
       
         if NewPassword != ConfirmPassword
        {
            
            self.MessageAlert(title:"",message:"Confirm password does not match with new password")
            return
        }
        self.view .endEditing(true)
        
        let param = ["oldPassword" : txtOldPassword.text!,"newPassword":txtNewPassword.text!]
        
        print(param)
        
        
        
        self.callChangePasswordApi(param: param as [String : Any])
        
       
        }
        
    func callChangePasswordApi(param : [String : Any]){
        ChangePasswordAPIRequest.shared.ChangePassword(requestParams: param) { (message, status,session) in
            
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

// MARK: - TextField Delegate

extension ChangePassword : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == " ") {
            return false
            
        }
        return true
    }
}



extension ChangePassword: EmptyStateDelegate {
    
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
