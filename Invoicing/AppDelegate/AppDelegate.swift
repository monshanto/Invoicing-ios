

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController
import Fabric
import Crashlytics
import Firebase
import GoogleSignIn
import GooglePlaces
import GoogleMaps
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookCore
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let myDouble = 3.1
//        let doubleStr = Double(format: "%.2f", myDouble) // "3.15"
//        print(doubleStr)
        
        sleep(UInt32(1.3))
        
        UIApplication.shared.registerForRemoteNotifications()
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        Analytics.setAnalyticsCollectionEnabled(true)
        
        
        GMSServices.provideAPIKey("AIzaSyCn4NaEzeh7g-qW7xtkYewa8xv7LI1cdwU")
        GMSPlacesClient.provideAPIKey("AIzaSyCn4NaEzeh7g-qW7xtkYewa8xv7LI1cdwU")

        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        
        

        if UserDefaults.standard.object(forKey: "Login") != nil{
           AddSliderView()
        }
        else
        {
            setRoot()
        }

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.SessionExpire(notification:)), name: Notification.Name("SessionExpire"), object: nil)

        
             //AddSliderView()
        return  ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    }
    
    @objc func SessionExpire(notification: Notification) {
        
        setRoot()
    }

    
    
    func AddSliderView()
    {

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let obj : TabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        
     //   let navigationController = UINavigationController(rootViewController: obj)
        
        let del = UIApplication.shared.delegate as! AppDelegate

        del.window?.rootViewController = obj
        
    }
    
    func setRoot(){
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
     
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
          let InitialScreenVccontroller = storyboard.instantiateViewController(withIdentifier: "InitialScreenVc")
          let LoginScreenVccontroller = storyboard.instantiateViewController(withIdentifier: "LoginVc")
          let SignupScreenVccontroller = storyboard.instantiateViewController(withIdentifier: "RegisterVc")
        let nav = UINavigationController()

        
        nav.viewControllers = [LoginScreenVccontroller,SignupScreenVccontroller,InitialScreenVccontroller]


        let del = UIApplication.shared.delegate as! AppDelegate
        
        
        

        del.window?.rootViewController = nav

    }
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation
        )
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, options: options)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        UserDefaults.standard.object(forKey: "DToken")
        UserDefaults.standard.synchronize()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
      //  Crashlytics.sharedInstance().crash()

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

