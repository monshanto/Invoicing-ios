
import UIKit
import GoogleSignIn
import Alamofire
import GoogleSignIn

class LoginVc: UIViewController {
   
    
    
    var CheckBool = false
    var eyeClick = true

    
    @IBOutlet weak var VE_CheckUncheck : UIView!
    @IBOutlet weak var IMG_CheckUncheck : UIImageView!
    
    @IBOutlet weak var TFT_Email : FloatLabelTextField!
    @IBOutlet weak var TFT_Password : FloatLabelTextField!
    
    
    @IBOutlet weak var BTNlogin : UIButton!
    @IBOutlet weak var BTNforgot : UIButton!
    @IBOutlet weak var BTNregister : UIButton!
    

    let del = UIApplication.shared.delegate as! AppDelegate

    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomizationTextFeild()
        CustomizationButton()
        
        
        
        IMG_CheckUncheck.image = UIImage.ionicon(with: .androidCheckboxOutlineBlank, textColor: UIColor.gray, size: CGSize(width: 30, height: 30))
        VE_CheckUncheck.isUserInteractionEnabled = true
        
        

   
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }

    
    
    // MARK: - Show Password Funcation

    func addEye(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(TFT_Password.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.reveal), for: .touchUpInside)
        TFT_Password.rightView = button
        TFT_Password.rightViewMode = .always
    }
    
    @IBAction func reveal(_ sender: UIButton) {
        if(eyeClick == true) {
            sender.setImage(UIImage(named: "eye"), for: .normal)
            TFT_Password.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
            TFT_Password.isSecureTextEntry = true
        }
        eyeClick = !eyeClick
    }
    
    
    // MARK: - Custome TextFeild
    func CustomizationTextFeild()
    {
        
        
        // Add  show/Hide Password
        addEye()
        
        // Set TextFeild Tag
        TFT_Email.tag = 1
        TFT_Password.tag = 2
        
        // Set TextFeild Tag
        TFT_Email.delegate = self
        TFT_Password.delegate = self
        
        
        // Set TextFeild Border
        self.setBorder(textfield: TFT_Email)
        self.setBorder(textfield: TFT_Password)
        
        // Set TextFeild title Active Text Colour
        
        TFT_Email.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Password.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
    }
    
    
    // MARK: - Custome Button
    func CustomizationButton()
    {
        BTNlogin.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        BTNforgot.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1), for: .normal)
        BTNregister.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1), for: .normal)
        
        
    }
  
    
   
    // MARK: - Set Textfield Border
    
    func setBorder(textfield : FloatLabelTextField){
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 3
        textfield.clipsToBounds = true
        textfield.setLeftPaddingPoints(15.0)
    }
    
    
    @IBAction fileprivate func btnRegisterAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVc") as! RegisterVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction  fileprivate func btnLogin(_ sender: Any) {
        
        //without spaces email
        let trimmedEmailName = TFT_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        //without spaces password
        let trimmedPassword = TFT_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)


        if (trimmedEmailName?.isEmpty)!{
            MessageAlert(title:"",message: "Please enter your email")

            return
        }
        if !((trimmedEmailName?.EmailValidation())!){
           MessageAlert(title:"",message: "You have entered an invalid email address.")
            return
        }
        if (trimmedPassword?.isEmpty)!{
            MessageAlert(title:"",message: "Please enter your password.")
            return
        }
        
        
        let params = ["email": TFT_Email.text!,"password": TFT_Password
            .text!,"deviceType":GlobalConstants.deviceType,"deviceToken":"Device Token".deviceToken,"language":GlobalConstants.language,"login_type":LoginType.Email.rawValue] as [String : Any]
        
        
        loginRequest(Params: params)

    }
    
    
    
    func dataRequest() {
      
    }
    
    
   
    
    
    @IBAction fileprivate func btnForgetPsdAction(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "Forgot Password!", message: "Please enter your registered email to get OTP.", preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter your email id"
        }
        alert.addAction(UIAlertAction(title: "DONE", style: .destructive, handler: { (action:UIAlertAction) in
            
        let answer = alert.textFields![0]
            
            print(answer.text!)
            
            //without spaces email
            let trimmedEmailName = answer.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            if (trimmedEmailName.isEmpty){
                self.MessageAlert(title:"",message: "Please enter your email")
                answer.becomeFirstResponder()
                return
            }
            if !((trimmedEmailName.EmailValidation())){
                self.MessageAlert(title:"",message: "You have entered an invalid email address.")
                answer.becomeFirstResponder()

                return
            }
            
            let param = ["email" : answer.text!]
            self.callForgotApi(param: param)
            
            
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    func callForgotApi(param : [String : Any]){
        ForgotAPIRequest.shared.forgotPassword(requestParams: param) { (message, status,Verification) in
            
            if status == true{
                self.NavigateClass(message: message!,email:param["email"] as! String)
               
            }else{
               
                
                if Verification == false
                {
                  
                    self.VerificationPopMessageAlert(title: "", message: message!,Email: param["email"] as! String)
                }
                else
                {
                    self.MessageAlert(title: "", message: message!)
                }
                
                
                
                
            }
        }
    }
    func NavigateClass(message:String,email:String) {
        
        let ResetViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        ResetViewController.message = message;
        ResetViewController.emailId = email
        self.navigationController?.pushViewController(ResetViewController, animated: true)
        
    }
    
    @IBAction func btnGoogleLogin(_ sender: Any)
    {
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "638196311893-irbv0mcdi14sjqiovaogheehhn18m95b.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance().delegate = self

        

    }
    
    @IBAction func btnFacebookLogin(_ sender: Any)
    {
       
        
    }
    @IBAction fileprivate func btnCancelAction(_ sender: Any) {
        
        
    }
    
    
    @IBAction fileprivate func btnDoneAction(_ sender: Any) {
    }
    
   
    
    func loginRequest(Params:[String: Any]){
        self.view.endEditing(true)
        
        
        LoginAPIRequest.shared.login(requestParams: Params) { (obj, msg, success,Verification) in
            
            if success == false {
                
                if Verification == false
                {
                    //without spaces email
                    let trimmedEmailName = self.TFT_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    self.VerificationPopMessageAlert(title: "", message: msg!,Email: trimmedEmailName!)
                }
                else
                {
                     self.MessageAlert(title: "", message: msg!)
                }
                

                }
           else
            {
                
                self.save(object: obj!)
                
                
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.AddSliderView()
               
                
            }
        }
        
        
   
    }
    
    

}



extension LoginVc : GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
//        let idToken = user.authentication.idToken // Safe to send to the server
//        let fullName = user.profile.name
        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
        let email = user.profile.email
        
        var imageURL = ""
        if user.profile.hasImage {
            imageURL = String(user.profile.imageURL(withDimension: 300).absoluteString)

        }
        
        
        
        print(email!)
        print(userId!)

        
        
        let params = ["email": email!,"google_id": userId!,"name":givenName!,"profile_pic":imageURL,"device_type":GlobalConstants.deviceType,"device_token":"Device Token".deviceToken,"language":GlobalConstants.language,"login_type":LoginType.Google.rawValue] as [String : Any]
        
        print(params)
        
        
        loginRequest(Params: params)
 
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
    }
    
    
    
}

extension LoginVc : UITextFieldDelegate
{
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == " ") {
            
            if textField.tag == 2
            {
                return false
            }
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
}


// MARK: - Set Textfield Padding Points
extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}


extension UIViewController
{
    func MessageAlert(title:String,message:String)
    {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok" , style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
    
    
    func VerificationPopMessageAlert(title:String,message:String,Email:String)
    {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok" , style: .default, handler:{ (UIAlertAction)in
            
            
            
            let VerifyEmail = self.storyboard?.instantiateViewController(withIdentifier: "VerifyEmail") as! VerifyEmail
           
            VerifyEmail.emailId = Email
            self.navigationController?.pushViewController(VerifyEmail, animated: true)
            
            
        }))
        
       
        
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
    
    func popMessageAlert(title:String,message:String)
    {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok" , style: .cancel, handler:{ (UIAlertAction)in
            
            
//            for controller in self.navigationController!.viewControllers as Array {
//                
//                
//                if controller.isKind(of: LoginVc.self) {
//                    self.navigationController!.popToViewController(controller, animated: true)
//                    break
//                }
//                
//            }
            
            self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
    func SessionMessageAlert(title:String,message:String)
    {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok" , style: .cancel, handler:{ (UIAlertAction)in
            
            
            NotificationCenter.default.post(name: Notification.Name("SessionExpire"), object: nil)

            
        }))
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    
}
