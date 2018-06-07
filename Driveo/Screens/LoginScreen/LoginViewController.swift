//
//  LoginViewController.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , LoginViewProtocol {
    
    var lp:LoginPresenterProtocol!
    var spinner:UIView!
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var wrongEmail: UILabel!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBAction func loginBut(_ sender: Any) {
        
        ChangeLabel(withString: "")
        if (emailTxt.text?.matches(String((String.regexes.email).rawValue)))! {
            lp.login(withUserName: emailTxt.text!, andPassword: passTxt.text!)
            showLoading()
        }
        else{
            ChangeLabel(withString: "Invalid E-mail")
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
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        ChangeLabel(withString: "")
        
        lp = LoginPresenter(withController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func ChangeLabel(withString str:String){
        wrongEmail.text = str
        dismissLoading()
    }
    func goToScreen(withScreenName name:String){
        if name == "next"{
            print("PickLoacationViewController")
            let sourceScreenStoryboard = UIStoryboard(name: "SourceScreen", bundle: nil)
            let signup = sourceScreenStoryboard.instantiateViewController(withIdentifier: "PickLoacationViewController")
            dismissLoading()
            self.present(signup, animated: true, completion: nil)
        }
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
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
      //  UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
        dismissLoading()
        var alert:UIAlertController = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(dismissAlertAction)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
