
import UIKit

class VerifyEmail: UIViewController {
    
    
      var emailId : String = ""

    @IBOutlet weak var LBL_OTP: UILabel!
    @IBOutlet weak var IMG_MailImage: UIImageView!
    
    @IBOutlet weak var VW_Bottom: UIView!
    @IBOutlet weak var BTN_Verification: UIButton!
    @IBOutlet weak var TFT_OTP: UITextField!
    @IBOutlet weak var LBL_Verification: UILabel!
    
    
    // MARK: - Setup Navigation bar
    
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.title = "Verification"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LBL_OTP.font = .LightTitleFont()
        TFT_OTP.font = .SubTitleFont()
        LBL_Verification.font = .TitleFont()
        BTN_Verification.titleLabel?.font = .TitleRegular()
        BTN_Verification.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0)
        
        VW_Bottom.isUserInteractionEnabled = true
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.ResendAction))
        self.VW_Bottom.addGestureRecognizer(gesture)

        
        self.navigationController?.navigationBar.isHidden = false
        
        
        self.PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)

    }

    @objc func ResendAction(sender : UITapGestureRecognizer) {
        
        
        let param = ["email" : emailId]
        self.callResendEmailApi(param: param)
        
    }
    

    @IBAction func Verification_Action(_ sender: Any) {
        
        
        if (TFT_OTP.text?.isEmpty)!{
            
            MessageAlert(title:"",message: "Please enter OTP")
            
            return
        }
        
        let param = ["email" : emailId,"code":TFT_OTP.text as Any] as [String : Any]
        self.callConfirmEmailApi(param: param)
        
    }
    
    
    
    
    func callResendEmailApi(param : [String : Any]){
        ResendEmailAPIRequest.shared.ResendEmail(requestParams: param) { (message, status,session) in
            
            if session == true
            {
                
                if status == true{
                    self.MessageAlert(title: "", message: message!)
                }
                else
                {
                    self.popMessageAlert(title: "", message: message!)
                }
            }
            else
            {
                self.popMessageAlert(title: "", message: message!)
            }
        }
        
    }

    
    
    func callConfirmEmailApi(param : [String : Any]){
        ConfirmEmailAPIRequest.shared.ConfirmEmail(requestParams: param) { (message, status,session) in
            
            if session == true
            {
            if status == true{
                
                 self.popMessageAlert(title: "", message: message!)
            }
            else
            {
                self.MessageAlert(title: "", message: message!)
            }
        }
            else
            {
                self.popMessageAlert(title: "", message: message!)
            }
    }
    
}


}
