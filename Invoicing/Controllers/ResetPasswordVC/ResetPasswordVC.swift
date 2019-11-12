
import UIKit
import EmptyStateKit
import Alamofire

class ResetPasswordVC: UIViewController {
    
    var message : String = ""
    var emailId : String = ""



    @IBOutlet weak var lblOldPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    let button = UIButton()

    
    // MARK: - Done Action

    @IBAction func DoneAction(_ sender: Any) {
        
        
       
    
        guard let OTP = txtOTP.text ,let NewPswrd = txtNewPassword.text , let CnfrmPswrd = txtConfirmPassword.text else
                {
                    return
                }
        
       
        if  OTP.count == 0
        
        {
            
            self.MessageAlert(title:"",message:"OTP Field can't be empty")
            return
        }
        
        if  !txtNewPassword.PasswordValidation()
        {
           
            self.MessageAlert(title:"",message:"Please ensure that you have at least 8 characters, including at least 1 letter and 1 digit")
            return
        }
        if NewPswrd != CnfrmPswrd
        {
        self.MessageAlert(title:"",message:"Confirm password does not match with new password")
            
            return
            
        }
        
        let param = ["code" : txtOTP.text!,"password":txtNewPassword.text!,"email":emailId]
        
        print(param)
        
        self.callResendPasswordApi(param: param as [String : Any])
        
        
        
    }
    
    
    func callResendPasswordApi(param : [String : Any]){
        ResetAPIRequest.shared.resetpassword(requestParams: param) { (message, status) in
            
            if status == true{
                

                self.NavigateClass(message: message!)
                
            }else{
                
                self.MessageAlert(title:"",message: message!)
                
            }
        }
    }
    
    
    func NavigateClass(message:String) {
        
        let alert = UIAlertController(title: "Invoicing", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
          
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: LoginVc.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
            

        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
        
    }
    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Reset Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
      
    }
    
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtOTP.Padding()
        txtOTP.textFieldBottomBorder()
        txtOTP.backgroundColor = UIColor.clear
        txtOTP.delegate = self
        txtOTP.tag = 1
        
        txtNewPassword.Padding()
        txtNewPassword.textFieldBottomBorder()
        txtNewPassword.isSecureTextEntry = true
        txtNewPassword.backgroundColor = UIColor.clear
        txtNewPassword.delegate = self
         txtNewPassword.tag = 2
        
        txtConfirmPassword.Padding()
        txtConfirmPassword.textFieldBottomBorder()
        txtConfirmPassword.isSecureTextEntry = true
        txtConfirmPassword.backgroundColor = UIColor.clear
        txtConfirmPassword.delegate = self
        txtConfirmPassword.tag = 3
        
        btnDone.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        self.navigationController?.navigationBar.isHidden = false
           PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)
        
        // Check InterNet Connection
        CheckInterNetConnection()
        
        
        self.MessageAlert(title:"",message: message)
    }
    
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }

    
    ///// Add Client / Save Button
    
    func RightActionButton(Title:String){
        
        button.frame =  CGRect(x: 0, y: 0, width: 70, height: 20)
        button.contentVerticalAlignment = .bottom
        button .setTitle(Title, for: .normal)
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        var items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.rightBarButtonItems = items
    }
    
    @objc func rightButtonAction(){
        let param = ["email" : emailId]
        self.callForgotApi(param: param)
        
    }
    
    
    
    func callForgotApi(param : [String : Any]){
        ForgotAPIRequest.shared.forgotPassword(requestParams: param) { (message, status,Verification) in
            
            if status == true{
                self.MessageAlert(title:"",message: message!)
                
            }else{
                
                self.MessageAlert(title:"",message: message!)
                
            }
        }
    }
    
    
    
  
}


extension ResetPasswordVC : UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == " ") {
        return false
         
        }
        return true
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
}


extension ResetPasswordVC: EmptyStateDelegate {
    
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
            
            button.removeFromSuperview()

            
        }
        else
        {
            RightActionButton(Title: "Resend")

            view.emptyState.hide()
            
        }
        
    }
    
}



