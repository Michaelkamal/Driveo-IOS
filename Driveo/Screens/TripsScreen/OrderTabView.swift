//
//  OrderTabView.swift
//  Driveo
//
//  Created by Admin on 6/8/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class OrderTabView: ButtonBarPagerTabStripViewController,OrdersViewProtocol {
    
    var spinner:UIView?
    
    var alert:UIAlertController?
    
    let orangeColor = UIColor(red:1, green:0.5, blue:0.18, alpha:1.0)
    let greyColor = UIColor.lightGray
    
    public var successFunction:(([String:[PresentedOrder]]) -> Void)!
    
    var ordersPresenter:OrdersPresenterProtocol!
    
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor.red
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = orangeColor
        settings.style.buttonBarHeight = 2.0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16.67)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = greyColor
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.greyColor
            newCell?.label.textColor = self?.greyColor
        }
        super.viewDidLoad()
        buttonBarView.addSubview(drawLine())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawLine() ->UIView{
        var line:UIView = UIView(frame: CGRect(x: 0, y: 53, width: 414, height: 0.5))
        line.backgroundColor = UIColor.black
        return line
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let historyView = UIStoryboard(name: "Trips", bundle: nil).instantiateViewController(withIdentifier: "History") as! OrderHistoryCollectionView
        historyView.parentTabView = self
        let upcomingView = UIStoryboard(name: "Trips", bundle: nil).instantiateViewController(withIdentifier: "History") as! OrderHistoryCollectionView
        upcomingView.parentTabView = self
        return [historyView, upcomingView]
    }
    
    func onLoadFailure(failure: String) {
        showAlert(withTitle: "Failed", andMessage: failure)
    }
    
    func getInfoForTabOf(orderType order: OrderType, useData: @escaping (_ : [String:[PresentedOrder]]) -> Void, page:String){
        
        ordersPresenter = OrdersPresenter(withView: self)
        successFunction = useData
        ordersPresenter.requestOrders(ofType : order, page:page)
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    @IBAction func exitView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onLoadSuccess(useData: [String : [PresentedOrder]]) {
        successFunction(useData)
    }
}
