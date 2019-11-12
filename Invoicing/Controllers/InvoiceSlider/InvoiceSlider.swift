

import UIKit
import UPCarouselFlowLayout

class InvoiceSlider: UIViewController {
    
    
    @IBOutlet fileprivate var Collectionview : UICollectionView!
    @IBOutlet fileprivate var pageController : UIPageControl!
    var imgArray : [String] = ["1","2","3","4","5","6","7","8"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupCollection()
        
        setupPageController()
        
    }
    
    
    fileprivate func setupPageController()
    {
        pageController.numberOfPages = imgArray.count
        //   self.pageController.hidesForSinglePage = true
    }
    
    func SetupCollection()
    {
        
        self.Collectionview.dataSource  = self
        self.Collectionview.delegate = self
        setupLayout()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // collection View Flow Layout
    fileprivate func setupLayout() {
        //        let layout = self.Collectionview.collectionViewLayout as! UPCarouselFlowLayout
        //        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 15)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension InvoiceSlider : UICollectionViewDataSource ,UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCell", for: indexPath) as? IntroductionCell
        cell?.img.image = UIImage(named: imgArray[indexPath.row])
        
        return cell ?? UICollectionViewCell()
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = self.Collectionview!.indexPathForItem(at: center) {
            self.pageController.currentPage = ip.row
        }
    }
   
}

extension InvoiceSlider
{
    class func instance() -> InvoiceSlider?
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller   = storyBoard.instantiateViewController(withIdentifier: "InvoiceSlider") as? InvoiceSlider
        
        return controller
        
    }
}


