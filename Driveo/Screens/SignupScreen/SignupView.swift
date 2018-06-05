//
//  SignupView.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class SignupView: UIViewController ,SignupViewProtocol{

    var spinner:UIView?
    
    var alert:UIAlertController?
    
    lazy var signupPresenter:SignupPresenter = SignupPresenter(signupView: self)
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBOutlet weak var confirmPasswordError: UILabel!
    
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var phoneError: UILabel!
    
    @IBOutlet weak var emaiError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
  
    
 @objc   func keyboardWillShow(notification: NSNotification) {
    let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.height
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.view.window?.frame.origin.y = -1 * keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
 @objc   func keyboardWillHide(notification: NSNotification) {
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
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
    
    
    
    
    func setEmailAlertLabel(errorMsg: String) {
        emaiError.text = errorMsg
    }
    
    func setPhoneAlertLabel(errorMsg: String) {
        phoneError.text  = errorMsg
    }
    
    func setPasswordAlertLabel(errorMsg: String) {
        passwordError.text = errorMsg
    }
    
    func setConfirmPasswordAlertLabel(errorMsg: String) {
        confirmPasswordError.text = errorMsg
    }
    
    
    func showLoading() {
         spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func showNoInternetAlert(){
        let connectionAlertView:UIAlertController = UIAlertController(title: "Error", message: ErrorType.internet.rawValue, preferredStyle: .alert)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        connectionAlertView.addAction(dismissAlertAction)
        self.present(connectionAlertView, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signupNewUser(_ sender: Any) {
        let user:User = User(email: emailTextField.text!, phone: phoneTextField.text!, password: passwordTextField.text!)
        user.confirmPassword = confirmPasswordTextField.text!
        signupPresenter.registerclicked(user:user)
    }
    
    @IBAction func goToLoginScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func goToVerifyScreen(){
        let verifyScreen:VerifyView = self.storyboard?.instantiateViewController(withIdentifier: "VerifyView") as! VerifyView
        self.present(verifyScreen, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }
}

extension SignupView : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField.tag {
        case 1:
            signupPresenter.isEmailValid(email: emailTextField.text!)
        case 2:
            signupPresenter.isPhoneValid(phone: phoneTextField.text!)
        case 3:
            signupPresenter.isPasswordValid(password: passwordTextField.text!)
        case 4:
            signupPresenter.isPasswordmatches(password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        default: break
            
        }
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
