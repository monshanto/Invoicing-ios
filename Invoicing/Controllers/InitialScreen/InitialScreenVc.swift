

import UIKit

class InitialScreenVc: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet fileprivate var collectionVw: UICollectionView!
    @IBOutlet fileprivate var pageControl: UIPageControl!
    
    @IBOutlet weak var BTNlogin : UIButton!
    @IBOutlet weak var BTNregister : UIButton!
    
    
    var object  = InitialModelClass()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BTNlogin.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        BTNregister.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).BlueColor(Alpha: 1)
        
        object.images = [#imageLiteral(resourceName: "Invoices"),#imageLiteral(resourceName: "payments"),#imageLiteral(resourceName: "Transactions")]
        object.infoText = ["Instant Information \n Anytime","Instant Information \n Anytime","Instant Information \n Anytime"]
        
        object.descriptionText = ["Lorem Lpsum is simply dummy text of the printing and typesetting industry .Lorem lpsum has been the industry's standard dummy text ever since the 1500s.","cndk Lpsum is simply dummy text of the printing and typesetting industry .Lorem lpsum has been the industry's standard dummy text ever since the 1500s.","Lorem Lpsum is simply dummy text of the printing and typesetting industry .Lorem lpsum has been the industry's standard dummy text ever since the 1500s."]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return object.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InitialScreenCvc
        cell!.imageVw.image = object.images[indexPath.row]
        cell!.lblInfo1.text = object.infoText[indexPath.row]
        cell!.txtLB.text = object.descriptionText[indexPath.row]
        self.pageControl.numberOfPages = object.images.count
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionVw.frame.width
        let availableHeight = collectionVw.frame.height
        
        
        return CGSize(width: availableWidth, height: availableHeight)
    }
    
    
    
    
    //UIScrollView INT TO COUNT
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    
    
    @IBAction fileprivate func btnLoginAction(_ sender: Any) {
        
        self.navigationController?.viewControllers.remove(at: 1)

        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller   = storyBoard.instantiateViewController(withIdentifier: "LoginVc") as? LoginVc
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
  
    
    @IBAction fileprivate func btnRegisterAction(_ sender: Any) {
        
        self.navigationController?.viewControllers.remove(at: 1)

        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller   = storyBoard.instantiateViewController(withIdentifier: "RegisterVc") as? RegisterVc
        
        self.navigationController?.pushViewController(controller!, animated: true)
      
    }
    
    
    
}

extension InitialScreenCvc
{
    class func instance() -> LoginVc?
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller   = storyBoard.instantiateViewController(withIdentifier: "LoginVc") as? LoginVc
        
        return controller
    }
    
    class func navigate() -> RegisterVc?{
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller   = storyBoard.instantiateViewController(withIdentifier: "RegisterVc") as? RegisterVc
        
        return controller
        
    }
}
