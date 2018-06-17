//
//  ChangePasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/15/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePasswordViewController: UIViewController,ChangePasswordViewProtocol {
    
    var spinner:UIView!
    var cPP:ChangePasswordPresenterProtocol!
    
    @IBOutlet weak var oldPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var newPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var newPasswordRepeat: SkyFloatingLabelTextField!
    

    @IBAction func didTapOnThreeBars(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if validatePasswordMainField() && validatePasswordSecondaryField() && validatePasswordOldField(){
            cPP.change(oldPassword: oldPassword.text!, withPassword: newPassword.text!, andRepeatePass: newPasswordRepeat.text!)
            print("matches")
            showLoading()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cPP = ChangePasswordPresenter(withController: self)
        oldPassword.delegate = self
        newPassword.delegate = self
        newPasswordRepeat.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validatePasswordOldField() -> Bool {
        if oldPassword.text!.validate(regex: String.regexes.password.rawValue) {
            oldPassword.errorMessage = ""
            return true
        }
        else{
            oldPassword.errorMessage = "Invalid password"
            return false
        }
    }
    
    func validatePasswordMainField() -> Bool {
        if newPassword.text!.validate(regex: String.regexes.password.rawValue) {
            newPassword.errorMessage = ""
            return true
        }
        else{
            newPassword.errorMessage = "Invalid password"
            return false
        }
    }
    
    func validatePasswordSecondaryField() -> Bool {
        if newPassword.text! == newPasswordRepeat.text! {
            newPasswordRepeat.errorMessage = ""
            return true
        }
        else{
            newPasswordRepeat.errorMessage = "Doesn't match"
            return false
        }
    }
    

    func goToScreen(withScreenName name: String) {
        
    }
    
    
    func showAlert(withTitle title: String, andMessage msg: String) {
        var alert:UIAlertController = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert, animated: true, completion: nil)
        var dismissAlertAction:UIAlertAction
        if title.lowercased() == "success"{
             dismissAlertAction = UIAlertAction(title: title, style: .default, handler: { (alert) in
                self.didTapOnThreeBars(UIButton())
            })}
        else{
             dismissAlertAction = UIAlertAction(title: "OK", style: .default)}
        
        alert.addAction(dismissAlertAction)
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ChangePasswordViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField {
        case oldPassword:
            validatePasswordOldField()
        case newPassword:
            validatePasswordMainField()
        case newPasswordRepeat:
            validatePasswordSecondaryField()
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
