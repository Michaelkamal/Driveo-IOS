//
//  OrderUpcomingCollectionView.swift
//  Driveo
//
//  Created by Admin on 6/16/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

private let reuseIdentifier = "TripCell"

class OrderUpcomingCollectionView: UICollectionViewController , UICollectionViewDelegateFlowLayout, IndicatorInfoProvider  {
    
    var alert:UIAlertController?
    var totalpageCount = 1
    var parentTabView:OrdersViewProtocol!
    var upcomingData:[String:[PresentedOrder]]!
    var upcomingTrips:[PresentedOrder] = []
    var pageCount = 1
    var spinner:UIView?
    var flagPagination = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let factor = 414 / UIScreen.main.bounds.width
        let subtractionValue = 34/factor
        let value = subtractionValue/2
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, value, 0, value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentTabView!.getInfoForTabOf(orderType: .UpcomingOrders , useData: useData,onFailure: retrieveFailed, page: String(pageCount))
        showLoading()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Upcoming")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return upcomingTrips.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionView?.register(UINib(nibName: "TripCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TripCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripCell", for: indexPath) as! TripCellCollectionView
        let index = indexPath.item
        
        cell.addressLabel.text = upcomingTrips[index].pickup_location
        cell.dateLabel.text = Date.getFormattedDate(string: upcomingTrips[index].time!)
        cell.idLabel.text = "id#" + String(upcomingTrips[index].order_id!)
        cell.orderStatusLabel.text = upcomingTrips[index].status
        
        switch upcomingTrips[index].payment_method!{
        case "visa":
            cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_visa")
        case "masterCard":
            cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_mastercard")
        case "cash":
            cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
        default:
            cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
        }
        // Configure the cell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let factor = 414 / UIScreen.main.bounds.width
        let subtractionValue = 34/factor
        return CGSize(width: UIScreen.main.bounds.width-subtractionValue, height: 142)
    }
    func retrieveFailed(_ message:String) -> Void {
        dismissLoading()
        showAlert(withTitle: "Failed", andMessage: message)
    }
    
    func useData(_ data:RequestOrdersResult) {
        print(data)
        upcomingTrips += data.data!["upcoming"]!
        totalpageCount = data.total_pages!
        self.collectionView?.reloadData()
        dismissLoading()
    }
    
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == upcomingTrips.count-1 && indexPath.section == 1 && totalpageCount > pageCount{
            pageCount+=1
            parentTabView!.getInfoForTabOf(orderType: .UpcomingOrders , useData: useData, onFailure: retrieveFailed, page: String(pageCount))
            print("pageCount")
            print(pageCount)
            flagPagination = false
            showLoading()
        }
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        flagPagination = true
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        alert = UIViewController.getCustomAlertController(ofErrorType: ErrorType.deleteTrip.rawValue, withTitle: ErrorType.errorTitle.rawValue)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .default)
        alert?.addAction(dismissAlertAction)
        
           let cell = collectionView.cellForItem(at: indexPath) as! TripCellCollectionView
        
        var idText = cell.idLabel.text
        let index = idText!.index(idText!.startIndex, offsetBy: 3)
        let finalString = idText?.substring(from: index)
      //  let finalStringNumber = String(finalString)
        let order_id = Int(finalString!)
        
        let deleteAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {UIAlertAction in
            
     
            
            
            if NetworkDAL.isInternetAvailable() == true {
                let defaults = UserDefaults.standard
                let networkObj = NetworkDAL.sharedInstance()
                self.showLoading()
                let sufficUrl = SuffixUrl.deleteOrder.rawValue + finalString!
                print(finalString!)
                networkObj.processPatchReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: sufficUrl, andParameters: ["order_id":order_id ], onSuccess: { (myData) in
                    self.dismissLoading()
                    do {
                        let response = try JSONDecoder().decode(GenericResult.self, from: myData)
                        if response.message == MsgResponse.success.rawValue {
                            //alert order deleted
                            // delete this element
                            self.upcomingTrips.remove(at: indexPath.row)
                            self.collectionView?.reloadData()
                            let deletionAlert = UIViewController.getAlertController(ofErrorType: ErrorType.orderDeleted, withTitle: ErrorType.errorTitle.rawValue)
                            self.present(deletionAlert, animated: true, completion: nil)
                        }
                    }catch{
                        //alert Connection Error
                        let connectionAlert = UIViewController.getAlertController(ofErrorType: ErrorType.internet, withTitle: ErrorType.errorTitle.rawValue)
                        self.present(connectionAlert, animated: true, completion: nil)
                    }
                }, onFailure: { (msg) in
                     self.dismissLoading()
                    }, headers: ["Authorization":defaults.string(forKey: "auth_token")!])
            }else{
                self.dismiss(animated: false, completion: nil)
                let connectionAlert = UIViewController.getCustomAlertController(ofErrorType: ErrorType.internet.rawValue, withTitle: ErrorType.errorTitle.rawValue)
                self.present(connectionAlert, animated: true, completion: nil)
            }
            
            })
        alert?.addAction(deleteAction)
        self.present(alert!, animated: true, completion: nil)
       
    }
    
}
