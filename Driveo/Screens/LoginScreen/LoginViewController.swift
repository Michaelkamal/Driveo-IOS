//
//  LoginViewController.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController , LoginViewProtocol {
    

    var lp:LoginPresenterProtocol!
    var spinner:UIView!
    
    @IBOutlet weak var passTxt: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTxt: SkyFloatingLabelTextField!
    
    @IBAction func loginBut(_ sender: Any) {
        
        if validateEmail() {
            lp.login(withUserName: emailTxt.text!, andPassword: passTxt.text!)
            showLoading()
        }
        
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        let forgotPassView = self.storyboard?.instantiateViewController(withIdentifier: "forgotPass")
        self.present(forgotPassView!, animated: true, completion: nil)
    }
    @IBAction func registerBut(_ sender: Any) {
        let signupStoryboard = UIStoryboard(name: "SignupStoryboard", bundle: nil)
        let signup = signupStoryboard.instantiateViewController(withIdentifier: "SignupView")
        self.present(signup, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lp = LoginPresenter(withController: self)
        emailTxt.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showErrorLabel(withString str:String){
       emailTxt.errorMessage = str
    }
    func goToScreen(withScreenName name:String){
        if name == "next"{
            let screen = ScreenController.sourceScreen
            let sourceScreenStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
            let sourceScreen = sourceScreenStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
            sourceScreen.modalTransitionStyle =  .crossDissolve
            self.present(sourceScreen, animated: true, completion: nil)
        }
        if name == "verification"{
            print("verification")
            let signupStoryboard = UIStoryboard(name: "SignupStoryboard", bundle: nil)
            let signup = signupStoryboard.instantiateViewController(withIdentifier: "VerifyView")
            self.present(signup, animated: true, completion: nil)
        }
        
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
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
    
    func validateEmail() -> Bool{
        if (emailTxt.text?.validate(regex: String.regexes.email.rawValue))! {
            showErrorLabel(withString: "")
            return true
        }
        else{
            showErrorLabel(withString: "Invalid Email")
            return false
        }
    }
    
    
    func loginFailed(withMessage message:String){
        showAlert(withTitle: "Failed", andMessage: message)
    }
    
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField {
        case emailTxt:
            validateEmail()
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
