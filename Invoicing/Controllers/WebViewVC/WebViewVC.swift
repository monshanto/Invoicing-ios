//
//  WebViewVC.swift
//  MedMobilie
//
//  Created by dr.mac on 31/01/19.
//  Copyright © 2019 dr.mac. All rights reserved.
//


import UIKit
import WebKit
import EmptyStateKit
import Alamofire


class WebViewVC: UIViewController, WKUIDelegate {
    
    @IBOutlet fileprivate  var webView : WKWebView!
    var linkUrl : URL?
    var MenuButton : Bool = false
    var titleName : String = ""
    
    // MARK: - Setup Navigation bar
    func PaintNavigationBar(TitleColor:UIColor,BackgroundColor:UIColor,BtnColor:UIColor)
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: TitleColor]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barTintColor = BackgroundColor
        
        // Back button Txet Color
        self.navigationController!.navigationBar.tintColor = BtnColor
        
    }
    
    
    // MARK: - Class life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let request = URLRequest(url: linkUrl!)
        webView.load(request)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.title = titleName
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PaintNavigationBar(TitleColor: UIColor.white, BackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1.0), BtnColor: UIColor.white)

        self.navigationController?.navigationBar.isHidden = false
        
        // Check InterNet Connection
        CheckInterNetConnection()

        
    }
    
    
    
}

// MARK: - WKNavigationDelegate


extension WebViewVC : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
    }
}



extension WKWebView {
    
    func loadUrl(string: String) {
        if let url = URL(string: string) {
            if self.url?.host == url.host {
                self.reload()
            } else {
                load(URLRequest(url: url))
            }
        }
    }
}


// MARK: - Class instance

extension WebViewVC
{
    class func instance()->WebViewVC?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as? WebViewVC
        
        
        return controller
    }
    
}


extension WebViewVC: EmptyStateDelegate {
    
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


