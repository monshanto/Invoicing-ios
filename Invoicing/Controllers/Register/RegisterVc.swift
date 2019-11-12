

import UIKit

class RegisterVc: UIViewController {
    
    var CheckBool = false
    var AusMask = "XXX XXX XXX"
    
    var eyePasswordClick = true
    var eyeConfirmPasswordClick = true
    
    
    @IBOutlet weak var VE_RefressCaptcha : UIView!
    @IBOutlet weak var IMG_RefressCaptcha : UIImageView!
    
    @IBOutlet weak var LBL_TermCondition : UILabel!
    
    
    @IBOutlet weak var TFT_Name : FloatLabelTextField!
    @IBOutlet weak var TFT_Email : FloatLabelTextField!
    @IBOutlet weak var TFT_Password : FloatLabelTextField!
    @IBOutlet weak var TFT_Confirm_Password : FloatLabelTextField!
    @IBOutlet weak var TFT_Code : FloatLabelTextField!
    @IBOutlet weak var TFT_Phone_Number : FloatLabelTextField!
    @IBOutlet weak var TFT_Captcha : FloatLabelTextField!
    
    
    @IBOutlet weak var captchaView: UIView!
    @IBOutlet weak var labelCaptcha: UILabel!
    
    let arr: String = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@#!%*"
    
    var currentCaptcha = ""
    
    
    enum MESSAGE {
        case MATCH
        case NOT_MATCH
    }
    
    
    
    
    @IBOutlet weak var BTNregister : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        CustomizationTextFeild()
        CustomizationButton()
        
        
        
        LBL_TermCondition.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        LBL_TermCondition.addGestureRecognizer(tap)
        
        
        reloadCaptcha()
        
        
        labelCaptcha.textColor = UIColor.white
        labelCaptcha.font = UIFont.systemFont(ofSize: 30)
        
        IMG_RefressCaptcha.isUserInteractionEnabled = true
        let TapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RefressCaptcha))
        IMG_RefressCaptcha.addGestureRecognizer(TapGestureRecognizer)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //Hide KeyBoard When touche on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view .endEditing(true)
    }

    
    
    func reloadCaptcha() {
        currentCaptcha = getRandomCaptcha()
        labelCaptcha.text = currentCaptcha
        captchaView.backgroundColor = getRandomColor()
        TFT_Captcha.text = ""
    }
    func getRandomCaptcha() -> String {
        var captcha = ""
        let count = UInt32(arr.count)
        
        let index1 = Int(arc4random_uniform(count))
        let index2 = Int(arc4random_uniform(count))
        let index3 = Int(arc4random_uniform(count))
        let index4 = Int(arc4random_uniform(count))
        let index5 = Int(arc4random_uniform(count))
        
        captcha = String(format: "%@%@%@%@%@", arguments: [arr[index1], arr[index2], arr[index3], arr[index4], arr[index5]])
        print("\(index1)-\(index2)-\(index3)-\(index4)-\(index5)-\(captcha)")
        return captcha
    }
    func getRandomColor() -> UIColor {
        let hue : CGFloat = (CGFloat(arc4random() % 256) / 256.0) // 0.0 to 1.0
        let saturation : CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.5 // 0.5 to 1.0, away from white
        let brightness : CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.5 // 0.5 to 1.0, away from black
        let color: UIColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        return color
    }
    
    func checkIsMatchTwoString() -> MESSAGE {
        let input = TFT_Captcha.text
        if input == currentCaptcha {
            
            return MESSAGE.MATCH
        } else {
            
            return MESSAGE.NOT_MATCH
        }
    }
    
    
    // MARK: - Custome TextFeild
    func CustomizationTextFeild()
    {
        // Set TextFeild Border
        
        
        self.setBorder(textfield: TFT_Name,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Email,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Password,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Confirm_Password,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Code,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Phone_Number,Color:UIColor.lightGray)
        self.setBorder(textfield: TFT_Captcha,Color:UIColor.lightGray)

        
        
        
        // Set TextFeild Delegate
        
        TFT_Name.delegate = self
        TFT_Email.delegate = self
        TFT_Password.delegate = self
        TFT_Confirm_Password.delegate = self
        TFT_Code.delegate = self
        TFT_Phone_Number.delegate = self
        TFT_Captcha.delegate = self
        
        
        // Set TextFeild Default Setting
        TFT_Code.placeholder = "+61"
      //  TFT_Code.isUserInteractionEnabled = false
        TFT_Code.textAlignment = .center
        
        
        
        
        // Set TextFeild title Active Text Colour
        
        TFT_Name.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Email.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Password.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Confirm_Password.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Code.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Phone_Number.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        TFT_Captcha.titleActiveTextColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        
        // Add  show/Hide Password
        ShowPassword()
        
        // Add  show/Hide Confirm Password
        ShowConfirmPassword()
        
    }
    
    
    
    func ShowPassword(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(TFT_Password.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.reveal), for: .touchUpInside)
        TFT_Password.rightView = button
        TFT_Password.rightViewMode = .always
    }
    
    func ShowConfirmPassword(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(TFT_Confirm_Password.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.Confirmreveal), for: .touchUpInside)
        TFT_Confirm_Password.rightView = button
        TFT_Confirm_Password.rightViewMode = .always
    }
    
    @IBAction func reveal(_ sender: UIButton) {
        if(eyePasswordClick == true) {
            sender.setImage(UIImage(named: "eye"), for: .normal)
            TFT_Password.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
            TFT_Password.isSecureTextEntry = true
        }
        eyePasswordClick = !eyePasswordClick
    }
    
    
    @IBAction func Confirmreveal(_ sender: UIButton) {
        if(eyeConfirmPasswordClick == true) {
            sender.setImage(UIImage(named: "eye"), for: .normal)
            TFT_Confirm_Password.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(named: "eye")?.maskWithColor(color: UIColor.lightGray), for: .normal)
            TFT_Confirm_Password.isSecureTextEntry = true
        }
        eyeConfirmPasswordClick = !eyeConfirmPasswordClick
    }
    
    
    // MARK: - Custome Button
    func CustomizationButton()
    {
        BTNregister.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        
    }
    
    // MARK: - Check Uncheck TapGesture
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        ActionSheet()
    }
    
    
    func ActionSheet()
    {
        
        let alert = UIAlertController(title: nil, message:  nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "User Agreement", style: .default , handler:{ (UIAlertAction)in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            let urlstring = GlobalConstants.UserAgreementURL
            let url = NSURL(string: urlstring)
            vc.linkUrl = url as URL?
            vc.titleName = "User Agreement"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title:"Terms of Service" , style: .default, handler:{ (UIAlertAction)in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            let urlstring = GlobalConstants.TermsServiceURL
            let url = NSURL(string: urlstring)
            vc.linkUrl = url as URL?
            vc.titleName = "Terms of Service"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title:"Privacy Policy" , style: .default, handler:{ (UIAlertAction)in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            let urlstring = GlobalConstants.PrivacyURL
            let url = NSURL(string: urlstring)
            vc.linkUrl = url as URL?
            vc.titleName = "Privacy Policy"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        
        alert.addAction(UIAlertAction(title:"Cancel" , style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    
    
    // MARK: - Set Textfield Border
    
    func setBorder(textfield : FloatLabelTextField,Color:UIColor){
        textfield.layer.borderColor = Color.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 3
        textfield.clipsToBounds = true
        if textfield.tag != 4
        {
            textfield.setLeftPaddingPoints(15.0)
        }
    }
    
    
    @objc func RefressCaptcha() {
        reloadCaptcha()
    }
    
    
    @IBAction func RegisterUser(_ sender: Any) {
        

     //   RedBoderline()
        
        //without spaces name
        let trimmedName = TFT_Name.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //without spaces email
        let trimmedEmailName = TFT_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces password
        _ = TFT_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces ConfirmPassword
        _ = TFT_Confirm_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces ConfirmPassword
        let trimmedPhoneNumber = TFT_Confirm_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        if (trimmedName?.isEmpty)!{
            MessageAlert(title:"",message: "Please enter your name")
            
            return
        }
        
        if (trimmedEmailName?.isEmpty)!{
            MessageAlert(title:"",message: "Please enter your email")
            
            return
        }
        if !((trimmedEmailName?.EmailValidation())!){
            MessageAlert(title:"",message: "You have entered an invalid email address.")
            return
        }
        if  !TFT_Password.PasswordValidation()
        {
            
            self.MessageAlert(title:"",message:"Please ensure that you have at least 8 characters, including at least 1 letter and 1 digit")
            return
        }
        if (trimmedPhoneNumber?.isEmpty)!{
            MessageAlert(title:"",message: "Please enter your phone number")
            
            return
        }
        
//        if  checkIsMatchTwoString() == MESSAGE.NOT_MATCH{
//
//            MessageAlert(title:"",message: "Captcha content not matched")
//
//            return
//
//        }
//
       
        
        let params = ["name":trimmedName!,"email": TFT_Email.text!,"password": TFT_Password
            .text!,"phone":trimmedPhoneNumber!,"deviceType":GlobalConstants.deviceType,"deviceToken":"Device Token".deviceToken,"language":GlobalConstants.language,"login_type":LoginType.Email.rawValue,"role":"admin","parentUserId":""] as [String : Any]
        
        
        SignupRequest(Params: params)

        
        
    }
    
    
    
    func RedBoderline()
    {
        
        
        //without spaces name
        let trimmedName = TFT_Name.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //without spaces email
        let trimmedEmailName = TFT_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces password
        let trimmedPassword = TFT_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces ConfirmPassword
        let trimmedConfirm_Password  = TFT_Confirm_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //without spaces ConfirmPassword
        let trimmedPhoneNumber = TFT_Confirm_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
       
        
        if (trimmedName?.isEmpty)!{
            self.setBorder(textfield: TFT_Name,Color: UIColor.red)

        }
        else{
            self.setBorder(textfield: TFT_Name,Color: UIColor.lightGray)

        }
        
        if (trimmedEmailName?.isEmpty)!{
            self.setBorder(textfield: TFT_Email,Color: UIColor.red)

        }
        else
        {
            self.setBorder(textfield: TFT_Email,Color: UIColor.lightGray)

        }
        
        if !((trimmedEmailName?.EmailValidation())!){
            self.setBorder(textfield: TFT_Email,Color: UIColor.red)

        }
        else
        {
            self.setBorder(textfield: TFT_Email,Color: UIColor.lightGray)

        }
        if  !TFT_Password.PasswordValidation()
        {
            self.setBorder(textfield: TFT_Password,Color: UIColor.red)

           
        }
        else
        {
            self.setBorder(textfield: TFT_Password,Color: UIColor.lightGray)

        }
        
        
        
        if (trimmedConfirm_Password?.isEmpty)!{
           
            self.setBorder(textfield: TFT_Confirm_Password,Color: UIColor.red)

        }
        else
        {
            self.setBorder(textfield: TFT_Confirm_Password,Color: UIColor.lightGray)


        }
        if (trimmedPhoneNumber?.isEmpty)!{
           
            self.setBorder(textfield: TFT_Phone_Number,Color: UIColor.red)

        }
        else
        {
            self.setBorder(textfield: TFT_Phone_Number,Color: UIColor.lightGray)

        }
        
//        if  checkIsMatchTwoString() == MESSAGE.NOT_MATCH{
//
//            self.setBorder(textfield: TFT_Captcha,Color: UIColor.red)
//
//        }
//        else
//        {
//            self.setBorder(textfield: TFT_Captcha,Color: UIColor.lightGray)
//
//        }
        
   
    }
    
    func SignupRequest(Params:[String: Any]){
        self.view.endEditing(true)
        
        
        SignupAPIRequest.shared.Signup(requestParams: Params) { (obj, msg, success) in
            
            if success == false {
                
                
                
                self.MessageAlert(title: "", message: msg!)
                
            }
            else
            {
                
                
                let VerifyEmail = self.storyboard?.instantiateViewController(withIdentifier: "VerifyEmail") as! VerifyEmail
                VerifyEmail.emailId = Params["email"] as! String
                self.navigationController?.pushViewController(VerifyEmail, animated: true)
                
                
              //  self.VerificationAlert(title: "", message: msg!,Email: Params["email"] as! String)
                
//                self.save(object: obj!)
//
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                appDelegate?.AddSliderView()
                
                
            }
        }
        
        
        
        
    }
    
    
    @IBAction fileprivate func btnAlreadyAccAction(_ sender: Any) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
//        self.navigationController?.pushViewController(vc, animated: true)
//
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    func VerificationAlert(title:String,message:String,Email:String)
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
    
    
    
    
}




extension RegisterVc : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if (textField == TFT_Phone_Number) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let numbersOnly = newString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let length = numbersOnly.count
            // Check for supported phone number length
            guard length <=  9 else {
                return false
            }
            textField.text = formattedMobileNumber(number: textField.text!, mask: AusMask)
            return true
        }
        else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    private func formattedMobileNumber(number: String , mask : String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
}

