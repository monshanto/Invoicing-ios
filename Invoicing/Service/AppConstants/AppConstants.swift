//  Constant.swift

import Foundation
import UIKit


struct GlobalConstants {
    
    static let UserAgreementURL: String = "https://salesrep.NeilMed.com/board"
    static let TermsServiceURL: String = "https://salesrep.NeilMed.com/board"
     static let PrivacyURL: String = "https://salesrep.NeilMed.com/board"
    static let deviceType: String = "iOS"
    static let language: String = "English"
     static let Messagetitle: String = "Invoicing"
    static let Count: Int = 10
    
}

enum LoginType : String{
    case Email = "email"
    case Google = "google"
    case Facebook = "facebook"
}

enum UserType : String{
    case Admin = "admin"
    case SubAdmin = "subadmin"
}

var AppUser : LoginObject{
    let userDefaults = UserDefaults.standard
    let decoded  = userDefaults.object(forKey: "Login") as! Data
    let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginObject
    return user
}


extension String{
    static let LocalBaseURL = "https://invoicesappapi.azurewebsites.net/api"
    static let LiveBaseURL = "http://18.216.80.91:3000"
    var path: String{
        return .LocalBaseURL
    }
    var deviceToken : String{
        if let token = UserDefaults.standard.object(forKey: "DToken"){
            return token as! String
        }
        return "rvcxZZgghjkjskjskajskjas"
    }
    
    
    
    /////// Login Process API \\\\\\\\\\\\\

    
    var LoginURL: String{
        return "Path".path + "/" + "Account/Login"
    }
    var RegisterURL: String{
        return "Path".path + "/" + "Account/Register"
    }
    
    var ConfirmEmailURL: String{
        return "Path".path + "/" + "Account/ConfirmEmail"
    }
    
    var ResendEmailURL: String{
        return "Path".path + "/" + "Account/ResendEmail"
    }
    
    
    var ForgotpasswordURL: String{
        return "Path".path + "/" + "Account/ForgotPassword"
    }
    var ResetpasswordURL: String{
        return "Path".path + "/" + "Account/ResetPassword"
    }
    
    
    
    
    
    
    
   
    var GetCurrencyURL: String{
        return "Path".path + "/" + "get_currency"
    }
    var CurrencyListURL: String{
        return "Path".path + "/" + "currency_list"
    }
    var SetCurrencyURL: String{
        return "Path".path + "/" + "set_currency"
    }
    
    var CreateTaxURL: String{
        return "Path".path + "/" + "create_tax"
    }
    var TaxListURL: String{
        return "Path".path + "/" + "tax_list"
    }
    var UpdateTaxURL: String{
        return "Path".path + "/" + "update_tax"
    }
    var DeleteTaxURL: String{
        return "Path".path + "/" + "delete_tax"
    }
    
      /////// Item Process API \\\\\\\\\\\\\
    
    var CreateitemURL: String{
        return "Path".path + "/" + "Management/CreateItem"
    }
    var ItemListURL: String{
        return "Path".path + "/" + "Management/ItemList"
    }
    var UpdateItemURL: String{
        return "Path".path + "/" + "Management/UpdateItem"
    }
    var DeleteItemURL: String{
        return "Path".path + "/" + "Management/DeleteItem"
    }
    
    
    /////// Customer Process API \\\\\\\\\\\\\

    
    var CreateCustomerURL: String{
        return "Path".path + "/" + "Management/CreateCustomer"
    }
    var CustomerListURL: String{
        return "Path".path + "/" + "Management/CustomerList"
    }
    var UpdateCustomerURL: String{
        return "Path".path + "/" + "Management/UpdateCustomer"
    }
    var DeleteCustomerURL: String{
        return "Path".path + "/" + "Management/DeleteCustomer"
    }
    
    
    var CreateInvoiceURL: String{
        return "Path".path + "/" + "create_invoice"
    }
    var InvoiceListURL: String{
        return "Path".path + "/" + "invoice_list"
    }
    var UpdateInvoiceURL: String{
        return "Path".path + "/" + "update_invoice"
    }
    var DeleteInvoiceURL: String{
        return "Path".path + "/" + "delete_invoice"
    }
    var SendDraftInvoice: String{
        return "Path".path + "/" + "send_draft"
    }
    
    
    /////// Setting Tab API \\\\\\\\\\\\\
    
    var LinkedUserURL: String{
        return "Path".path + "/" + "User/LinkedUsers"
    }
    
    var DeleteLinkedUserURL: String{
        return "Path".path + "/" + "User/DeleteLinkedUser"
    }
    
    var EditProfileURL: String{
        return "Path".path + "/" + "User/UpdateProfile"
    }
    
    var ShowprofileURL: String{
        return "Path".path + "/" + "User/ShowProfile"
    }
    
    
    var GetCountryListURL: String{
        return "Path".path + "/" + "Management/GetCountryStateList"
    }
  
    var ShowAddressURL: String{
        return "Path".path + "/" + "User/ShowAddress"
    }
    var UpdateAddressURL: String{
        return "Path".path + "/" + "User/UpdateAddress"
    }
    
    var UpdateProfilePicURL: String{
        return "Path".path + "/" + "update_profile_pic"
    }
    var DeleteProfilePicURL: String{
        return "Path".path + "/" + "delete_profile_pic"
    }
    
    var ChangePasswordURL: String{
        return "Path".path + "/" + "Account/ChangePassword"
    }
    
    var LogOutURL: String{
        return "Path".path + "/" + "Account/Logout"
    }
    
}


