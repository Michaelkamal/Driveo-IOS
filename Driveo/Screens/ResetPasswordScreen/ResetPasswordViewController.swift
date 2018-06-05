//
//  ResetPasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, ResetPasswordViewProtocol {
    
    var spinner:UIView!
    var rPP:ResetPasswordPresenterProtocol!
    
    @IBOutlet weak var passwordFld1: UITextField!
    @IBOutlet weak var invalidPassLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var passwordFld2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        invalidPassLbl.isHidden = true
        messageLbl.isHidden = true
        rPP = ResetPasswordPresenter(withController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToScreen(withScreenName name: String) {
        
    }
    
    func ChangeLabel(withString str: String) {
        messageLbl.isHidden = false
        messageLbl.text=str
        dismissLoading()
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
        self.present(loginView!, animated: true, completion: nil)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        if true{
            invalidPassLbl.isHidden = true
            messageLbl.isHidden = true
            rPP.resetPassword(withPassword: passwordFld1.text!)
            print("matches")
            showLoading()
        }
        else{
            invalidPassLbl.isHidden = false
            invalidPassLbl.text = "Invalid password"
        }
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
