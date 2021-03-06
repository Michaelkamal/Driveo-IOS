//
//  SpinnerExtention.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.isHidden=true
            spinner.removeFromSuperview()
        }}
    class func getAlertController(ofErrorType err: ErrorType,withTitle title: String)-> UIAlertController{
        let alert = UIAlertController(title: title, message: err.rawValue, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: nil)
        alert.addAction(cancelAction)
        return alert
        
    }
    class func getCustomAlertController(ofErrorType err: String,withTitle title: String)-> UIAlertController{
        let alert = UIAlertController(title: title, message: err, preferredStyle: UIAlertControllerStyle.alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: nil)
//        alert.addAction(cancelAction)
        return alert
        
    }
}
// MARK : transition to present from left
extension UIViewController{
        
        func pushFromLeft(_ viewControllerToPresent: UIViewController) {
            self.navigationController?.pushViewController(viewControllerToPresent, animated: false)
            self.navigationController?.pushViewController(UIViewController(), animated: false)
            self.navigationController?.popViewController(animated: true)
    }
        
        func popToLeft() {
            self.navigationController?.popViewController(animated: true)
        }
}
extension UIViewController{
    class func displayCircularProgressBar(onView : UIView,withMaxValue max:Double) -> (backGround:UIView,progressBar:CircularProgress) {
        let progressBarView = UIView.init(frame: onView.bounds)
        progressBarView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let progressBar = CircularProgress()
        let size = onView.frame.size.width/3
        progressBar.frame.size=CGSize(width:size,height:size)
        progressBar.center=onView.convert(onView.center, from:onView.superview)
        progressBar.trackColor=UIColor.gray
        progressBar.IBColor1=UIColor.green
        progressBar.angle = 0
        progressBar.maxCount=max
        DispatchQueue.main.async {
            progressBarView.addSubview(progressBar)
            onView.addSubview(progressBarView)
        }
        return (progressBarView,progressBar)
    }
}
