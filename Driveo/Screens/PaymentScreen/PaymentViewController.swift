//
//  PaymentViewController.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SDWebImage
class PaymentViewController: UIViewController {

    private var presenter:PaymentPresenter!
    private var paymentMethods:[PaymentMethod]=[]
    public var userOrder:Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=PaymentPresenter(withController: self,andOrder: userOrder)
        
    }

  

}
extension PaymentViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as? PaymentCell
        if let cell = cell{
            cell.paymentTitle.text=paymentMethods[indexPath.row].name
            cell.paymentImage.sd_setImage(with: URL(string: ApiBaseUrl.mainApi.rawValue+paymentMethods[indexPath.row].image!.url!), completed:nil)
            if let isSelected = paymentMethods[indexPath.row].isSelected {
                if(isSelected)
                {
                    cell.selectImage.isHidden=false
                }else
                {
                   cell.selectImage.isHidden=true
                }
            }
            else{
               paymentMethods[indexPath.row].isSelected=false
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i  in 0..<paymentMethods.count{
            paymentMethods[i].isSelected = false
        }
        paymentMethods[indexPath.row].isSelected=true
        tableView.reloadData()
        presenter.didSelectPaymentMethod(paymentMethodID: paymentMethods[indexPath.row].id!)
    }
    
    
}
