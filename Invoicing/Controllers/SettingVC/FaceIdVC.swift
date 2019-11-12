//
//  FaceIdVC.swift
//  MedMobilie
//
//  Created by dr.mac on 16/05/19.
//  Copyright © 2019 dr.mac. All rights reserved.
//

import UIKit
import LocalAuthentication

class FaceIdVC: UIViewController {
    
    
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
//
//    // MARK: - FaceId Button Action
//
//    @IBAction fileprivate func FaceIdBtn(_ sender : UIButton)
//    {
//
//            let localAuthenticationContext = LAContext()
//            localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
//
//            var authError: NSError?
//            let reasonString = "To access the secure data"
//
//            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
//
//                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
//
//                    if success {
//                        DispatchQueue.main.async {
//                            RootControllerManager().setRoot()
//                        }
//
//                        //TODO: User authenticated successfully, take appropriate action
//
//                    } else {
//                        //TODO: User did not authenticate successfully, look at error and take appropriate action
//
//                        guard let error = evaluateError else {
//                            return
//                        }
//
//
//                        DispatchQueue.main.async {
//                            //self.displayErrorMessage(error: error as! LAError )
//                           if LAError.userFallback.rawValue == error._code
//                           {
//
//                            }
//            print(FaceIDErrorConstant.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
//                        }
//
//
//                        //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
//
//                    }
//                }
//            } else {
//
//                guard let error = authError else {
//                    return
//                }
//
//                //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
//                print(FaceIDErrorConstant.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
//            }
//
//    }
//
//
//
//}
//
//
//// MARK: - Class instance
//
//extension FaceIdVC
//{
//    class func instance()->FaceIdVC?{
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "FaceIdVC") as? FaceIdVC
//        //self.definesPresentationContext = true
//
//        return controller
//    }
//}
