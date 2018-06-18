//
//  OrderHistoryCollectionView.swift
//  Driveo
//
//  Created by Admin on 6/9/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

private let reuseIdentifier = "TripCell"

class OrderHistoryCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout, IndicatorInfoProvider  {
    
    var alert:UIAlertController?
    var totalpageCount = 1
    var parentTabView:OrdersViewProtocol!
    var activeTrips:[PresentedOrder] = []
    var pastTrips:[PresentedOrder] = []
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
    
        parentTabView!.getInfoForTabOf(orderType: .HistoryOrders , useData: useData,onFailure: retrieveFailed, page: String(pageCount))
        showLoading()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return activeTrips.count
        default:
            return pastTrips.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionView?.register(UINib(nibName: "TripCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TripCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripCell", for: indexPath) as! TripCellCollectionView
        let index = indexPath.item
        
        switch indexPath.section {
        case 0:
            cell.addressLabel.text = activeTrips[index].pickup_location
            cell.dateLabel.text = Date.getFormattedDate(string: activeTrips[index].time!)
            cell.idLabel.text = "id#" + String(activeTrips[index].order_id!)
            cell.orderStatusLabel.text = activeTrips[index].status
            
            switch activeTrips[index].payment_method!{
            case "visa":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_visa")
            case "masterCard":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_mastercard")
            case "cash":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
            default:
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
            }
        default:
            cell.addressLabel.text = pastTrips[index].pickup_location
            let dateString = Date.getFormattedDate(string: pastTrips[index].time!)
            print("shiekh",dateString)
            cell.dateLabel.text = dateString
            cell.idLabel.text = "id#" + String(pastTrips[index].order_id!)
            cell.orderStatusLabel.text = pastTrips[index].status
            cell.priceLabel.text = String(pastTrips[index].cost!)
            switch pastTrips[index].payment_method!{
            case "visa":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_visa")
            case "masterCard":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_mastercard")
            case "cash":
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
            default:
                cell.paymentImage.image = #imageLiteral(resourceName: "ic_payment_cash")
            }
            
        }
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
             //self.collectionView?.register(UINib(nibName: "HeaderCollection", bundle: nil), forCellWithReuseIdentifier: "headerCollection")
             
             self.collectionView?.register(UINib(nibName: "HeaderCollection", bundle: nil),
                                              forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                              withReuseIdentifier: "headerCollection")
 
             let headerView:HeaderCollection = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCollection", for: indexPath) as! HeaderCollection
             
            //do other header related calls or settups
             switch indexPath.section {
             case 0:
                headerView.headerLabel.text = "Active"
             default:
                headerView.headerLabel.text = "Past"
             }
            
            return headerView
            
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let factor = 414 / UIScreen.main.bounds.width
        let subtractionValue = 34/factor
        return CGSize(width: UIScreen.main.bounds.width-subtractionValue, height: 43)

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
        dismissLoading()
        print(data)
        if pastTrips.count == 0 {
            activeTrips += data.data!["active"]!
        }
        pastTrips += data.data!["history"]!
        totalpageCount = data.total_pages!
        self.collectionView?.reloadData()
        
    }
    
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == pastTrips.count-1 && indexPath.section == 1 && totalpageCount > pageCount{
            pageCount+=1
            parentTabView!.getInfoForTabOf(orderType: .HistoryOrders , useData: useData, onFailure: retrieveFailed, page: String(pageCount))
            print("pageCount")
            print(pageCount)
            flagPagination = false
            showLoading()
        }
    }
    func showAlert(withTitle title :String , andMessage msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }
    
}
