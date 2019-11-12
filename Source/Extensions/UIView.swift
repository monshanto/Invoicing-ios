

import Foundation
import UIKit


public extension UIView {
    /*@IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }*/
    
   
   
    func cornerRadiusForView(Value : CGFloat)
    {
        self.layer.cornerRadius = Value
        self.layer.masksToBounds = true
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    public class func fromNib(nibName: String?) -> Self {
        func fromNibHelper<T>(nibName: String?) -> T where T : UIView {
            let bundle = Bundle(for: T.self)
            let name = nibName ?? String(describing: T.self)
            return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T ?? T()
        }
        return fromNibHelper(nibName: nibName)
    }
    

    /*func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }*/
    func addConstraints(childView : UIView){
        let metrics = [String : Int]()
        let viewInfos = ["childView" : childView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[childView]-0-|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewInfos))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[childView]-0-|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewInfos))
        
    }
    
    func addBottomConstraint(bottom : CGFloat = 0, childView : UIView){
        var metrics = [String : CGFloat]()
        metrics["bottom"] = bottom
        let viewInfos = ["childView" : childView]
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[childView]-bottom-|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewInfos))
    }
    func bottomViewShadow(ColorName: UIColor)
    {
    self.layer.masksToBounds = false
    self.layer.shadowRadius = 2
    self.layer.shadowOpacity = 0.8
    self.layer.shadowColor = ColorName.cgColor
    self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
        public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    // swiftlint:disable:next identifier_name
    public var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    // swiftlint:disable:next identifier_name
    public var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
   
    public var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    public var centerX: CGFloat {
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue, y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX, y: newValue) }
    }
    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    
    
    
    func addCenterConstraints(childView : UIView) {
        addCenterHorizontalConstraint(childView: childView)
        addCenterVerticalConstraint(childView: childView)
    }
    
    func addCenterHorizontalConstraint(childView : UIView){
        let metrics = [String : Int]()
        childView.translatesAutoresizingMaskIntoConstraints = false
        let viewInfos = ["childView" : childView, "superview" : self]
        // Center horizontally
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[childView]",
            options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
            metrics: metrics,
            views: viewInfos)
        
        self.addConstraints(constraints)
    }
    
    func addCenterVerticalConstraint(childView : UIView){
        let metrics = [String : Int]()
        childView.translatesAutoresizingMaskIntoConstraints = false
        let viewInfos = ["childView" : childView, "superview" : self]
        
        // Center vertically
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[childView]",
            options: NSLayoutConstraint.FormatOptions.alignAllCenterY,
            metrics: metrics,
            views: viewInfos)
        
        self.addConstraints(constraints)
    }
    
    func addWidthConstraint(width : CGFloat){
        let metrics = [String : Int]()
        let viewInfos = ["self" : self]
        let constraint = String(format : "H:[self(%f)]", width)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewInfos))
        
    }
    
    func addHeightConstraint(height : CGFloat){
        let metrics = [String : Int]()
        let viewInfos = ["self" : self]
        
        let constraint = String(format : "V:[self(%f)]", height)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewInfos))
        
    }
   
        func addDashedBorder() {
            let color = UIColor.red.cgColor
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor(red: 41, green: 148, blue: 156, alpha: 1.0).cgColor
            shapeLayer.lineWidth = 1
            shapeLayer.lineDashPattern = [2,3] // 7 is the length of dash, 3 is length of the gap.
            let minX = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
            let maxX = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
            let path = CGMutablePath()
            path.addLines(between: [minX,maxX])
            shapeLayer.path = path
            self.layer.addSublayer(shapeLayer)

        }
    func createCircleForView () {
        
        let radius = self.frame.height/2.0
        self.layer.cornerRadius = radius
        //self.layer.masksToBounds = false
       self.clipsToBounds = true
        
        self.contentMode = .scaleAspectFill
    }
    
    
    
}
