

import UIKit
import NVActivityIndicatorView

class Indicator: NSObject , NVActivityIndicatorViewable {
    var activityData = ActivityData()
    static let shared = Indicator()
    
    func startAnimating(withMessage : String) {
        activityData = ActivityData(size: CGSize(width: 80, height: 80),
                                    message: withMessage,
                                    messageFont: UIFont(name: "Avenir-Roman", size: 14),
                                    type: NVActivityIndicatorType.ballScaleMultiple,
                                    color: UIColor.white,
                                    padding: 0,
                                    displayTimeThreshold: NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD,
                                    minimumDisplayTime: NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME,
                                    backgroundColor: NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR,
                                    textColor: NVActivityIndicatorView.DEFAULT_TEXT_COLOR)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
    }
    func stopAnimating(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
