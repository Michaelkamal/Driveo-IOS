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
    
    var spinner: UIView?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func didTapOnThreeBars(_ sender: UIButton) {
        let screen = ScreenController.navigationDrawerScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        pushFromLeft(vc)
    }
    
    @IBAction func didTapOnSubmitButton(_ sender: RoundedButton) {
        presenter.submitFunc()
    }
    
    private var presenter:PaymentPresenter!
    
    private var paymentMethods:[PaymentMethod]=[]
    
    public var userOrder:Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=PaymentPresenter(withController: self)
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
            cell.paymentImage.sd_setImage(with: URL(string: method.image!.url!), completed:nil)
            if(method.isSelected || userOrder?.paymentMethod?.id == method.id)
            {
                cell.selectImage.isHidden=false
            }else
            {
                cell.selectImage.isHidden=true
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
            for i  in 0..<paymentMethods.count{
                paymentMethods[i].isSelected = false
            }
            paymentMethods[indexPath.row].isSelected=true
            tableView.reloadData()
            presenter.didSelectPaymentMethod(paymentMethod: paymentMethods[indexPath.row])
        }
}

extension PaymentViewController: PaymentViewProtocol {
    func updateTableViewData(withArray array: [PaymentMethod]) {
        paymentMethods=array
        tableView.reloadData()
        dismissLoading()
    }
    
    // show alert
    
    func showAlert(ofError error:ErrorType)->Void{
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            self.presentToNextScreen()
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentToNextScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        if let spinner=spinner{
        UIViewController.removeSpinner(spinner: spinner)
        }}
}
