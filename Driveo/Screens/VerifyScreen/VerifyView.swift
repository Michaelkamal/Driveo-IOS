//
//  VerifyView.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class VerifyView: UIViewController , VerifyViewProtocol, UITextFieldDelegate{
    
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var errorCodeLabel: UILabel!
    private lazy var presenter:VerifyPresenterProtocol = VerifyPresenter(view: self)
    
     var spinner:UIView?
    var alert:UIAlertController?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setCodeErrorLabel(withError: String) {
        
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func goToHomeScreen() {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeScreen:SourceViewController = storyBoard.instantiateViewController(withIdentifier: "SourceViewController") as! SourceViewController
        self.present(homeScreen, animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String, andMsg msg: String) {
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
        self.present(alert!, animated: true, completion: nil)
    }
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        presenter.sendVerificationCode(withcode: verificationCodeTextField.text!)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField.tag {
        case 1:
            presenter.isCodeValid(withCode: textField.text!)
        default: break
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
