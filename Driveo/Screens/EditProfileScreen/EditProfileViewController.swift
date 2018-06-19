//
//  SignupView.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileViewController: UIViewController {

    var spinner:UIView?
    
    lazy var presenter:EditProfilePresenter = EditProfilePresenter(withController: self)
    
    @IBAction func didTapOnThreeBars(_ sender: Any) {
        presentToNextScreen()
    }
    @IBOutlet weak var emailTextField:SkyFloatingLabelTextField!

    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
emailTextField.text=UserDAL.sharedInstance().getUser()?.email
        phoneTextField.text=UserDAL.sharedInstance().getUser()?.phone
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
    
    @IBAction func editUser(_ sender: Any) {
        var user:User = User(email: emailTextField.text!, phone: phoneTextField.text!, password: "", confirmPassword: "")
        
        presenter.editUser(user:user)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
}

extension EditProfileViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField.tag {
        case 1:
            presenter.isEmailValid(email: emailTextField.text!)
        case 2:
            presenter.isPhoneValid(phone: phoneTextField.text!)
        default: break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
extension EditProfileViewController:EditProfileProtocol{
    
    func presentToNextScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setEmailAlertLabel(errorMsg: String) {
        emailTextField.errorMessage = errorMsg
    }
    
    func setPhoneAlertLabel(errorMsg: String) {
        phoneTextField.errorMessage = errorMsg
        
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    func showAlert(ofError error:ErrorType)->Void{
        let alert = UIViewController.getAlertController(ofErrorType: error, withTitle: "Error")
        guard let visibleViewController = self.navigationController?.visibleViewController else{
            present(alert, animated: true, completion: nil)
            return
        }
        if !visibleViewController.isKind(of: UIAlertController.self)  {
            present(alert, animated: true, completion: nil)
        }
    }
}

