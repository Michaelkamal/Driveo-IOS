//
//  ResetPasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ResetPasswordViewController: UIViewController, ResetPasswordViewProtocol {
    
    var spinner:UIView!
    var rPP:ResetPasswordPresenterProtocol!
    
    @IBOutlet weak var passwordFld1: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordFld2: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        rPP = ResetPasswordPresenter(withController: self)
        passwordFld2.delegate = self
        passwordFld1.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToScreen(withScreenName name: String) {
        
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
        self.present(loginView!, animated: true, completion: nil)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        if validatePasswordMainField() && validatePasswordSecondaryField(){
            rPP.resetPassword(withPassword: passwordFld1.text!)
            print("matches")
            showLoading()
        }
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func validatePasswordMainField() -> Bool {
        if passwordFld1.text!.validate(regex: String.regexes.password.rawValue) {
            passwordFld1.errorMessage = ""
            return true
        }
        else{
            passwordFld1.errorMessage = "Invalid password"
            return false
        }
    }
    
    func validatePasswordSecondaryField() -> Bool {
        if passwordFld1.text! == passwordFld2.text! {
            passwordFld2.errorMessage = ""
            return true
        }
        else{
            passwordFld2.errorMessage = "Doesn't match"
            return false
        }
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
        var alert:UIAlertController = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(dismissAlertAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResetPasswordViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField {
        case passwordFld1:
            validatePasswordMainField()
        case passwordFld2:
            validatePasswordSecondaryField()
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
