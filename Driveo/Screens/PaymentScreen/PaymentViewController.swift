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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnSubmitButton(_ sender: RoundedButton) {
        presenter.submitFunc()
    }
    
    private var presenter:PaymentPresenter!
    
    private var paymentMethods:[PaymentMethod]=[]
    
    public var userOrder:Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=PaymentPresenter(withController: self,andOrder: userOrder)
        presenter.getPaymentDataArray()
        tableView.rowHeight=tableView.frame.height/4
    }
    
    
    
}

extension PaymentViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as? PaymentCell
        if let cell = cell{
            let method = paymentMethods[indexPath.row]
            cell.paymentTitle.text=method.name
            cell.paymentImage.sd_setImage(with: URL(string: //ApiBaseUrl.mainApi.rawValue+
                method.image!.url!), completed:nil)
            if(method.isSelected || userOrder?.paymentMethod?.id == method.id)
            {
                cell.selectImage.isHidden=false
            }else
            {
                cell.selectImage.isHidden=true
            }
            if method.isEnable == false {
                cell.paymentSubtitle.text="Not available"
            }
        }
        if( tableView.rowHeight * CGFloat(paymentMethods.count) < tableView.frame.height)
        {
            tableView.isScrollEnabled=false
        }
        else
        {
            tableView.isScrollEnabled=true
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (paymentMethods[indexPath.row].isEnable)
        {
            for i  in 0..<paymentMethods.count{
                paymentMethods[i].isSelected = false
            }
            paymentMethods[indexPath.row].isSelected=true
            tableView.reloadData()
            presenter.didSelectPaymentMethod(paymentMethod: paymentMethods[indexPath.row])
        }}
}

extension PaymentViewController: PaymentViewProtocol {
    func updateTableViewData(withArray array: [PaymentMethod]) {
        paymentMethods=array
        tableView.reloadData()
        
    }
    
    // show alert
    
    func showAlert(ofError error:ErrorType)->Void{
        let alert = UIViewController.getAlertController(ofErrorType: error, withTitle: "Error")
        present(alert, animated: true, completion: nil)
    }
    
    func presentToNextScreen(withOrder order: Order) {
        let createOrderStoryboard = UIStoryboard(name: ScreenController.createOrderScreen.storyBoardName(), bundle: nil)
        let vc = createOrderStoryboard.instantiateViewController(withIdentifier: ScreenController.createOrderScreen.rawValue) as! CreateOrderViewController
        vc.userOrder=order
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true,completion: nil)
        
    }
    
}
