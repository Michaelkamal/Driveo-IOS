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
    
    var parentTabView:OrdersViewProtocol!
    var historyData:[String:[OrderMock]]!
    var spinner:UIView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let factor = 414 / UIScreen.main.bounds.width
        let subtractionValue = 34/factor
        let value = subtractionValue/2
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, value, 0, value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parentTabView!.getInfoForTabOf(orderType: .HistoryOrders , useData: useData)
        
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionView?.register(UINib(nibName: "TripCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TripCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripCell", for: indexPath) as! TripCellCollectionView
        
        cell.priceLabel.text = ""
        
   
    
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
            headerView.headerLabel.text = "Active"
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


    func useData(_ data:[String:[OrderMock]]) {
        historyData = data
    }
    
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }

}
