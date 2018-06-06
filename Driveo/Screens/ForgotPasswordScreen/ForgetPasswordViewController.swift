//
//  ForgetPasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, ForgotPassViewProtocol {
    
    var spinner:UIView!
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var wrongMailLbl: UILabel!
    var fPP:ForgotPassPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        wrongMailLbl.isHidden = true
        fPP = ForgotPassPresenter(withController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendLink(_ sender: UIButton) {
        if (emailTxt.text?.matches(String.regexes.email.rawValue))!{
            wrongMailLbl.isHidden = true
            fPP.sendLink(withEmail: emailTxt.text!)
            print("matches")
            showLoading()
        }
        else{
            ChangeLabel(withString: "Invalid email")
        }
    }
    func goToScreen(withScreenName name: String) {
        dismissLoading()
    }
    
    func ChangeLabel(withString str: String) {
        wrongMailLbl.text = str
        wrongMailLbl.isHidden = false
        if !str.contains("invalid email"){
            dismissLoading()}
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
