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
    
    let orangeColor = UIColor(red:1, green:0.5, blue:0.18, alpha:1.0)
    let greyColor = UIColor.lightGray
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
        var line:UIView = UIView(frame: CGRect(x: 0, y: 125, width: 414, height: 200))
        line.backgroundColor = greyColor
        return line
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let historyView = UIStoryboard(name: "Trips", bundle: nil).instantiateViewController(withIdentifier: "History") as! OrderHistoryTableView
        let upcomingView = UIStoryboard(name: "Trips", bundle: nil).instantiateViewController(withIdentifier: "Upcoming")
        return [historyView, upcomingView]
    }
    
    func onLoadFailure(failure: String) {
        
    }
    
    func getInfoForTabOf(orderType order: OrderType) -> [String:[OrderMock]]{
        let temp = OrderMock(date: "1/1/1", price: 50, from: "120", to: "220", payment: "cash", status: .active)
        let arr = [temp,temp,temp]
        let tripsDictionatry = ["History":arr]
        return tripsDictionatry
    }

}
