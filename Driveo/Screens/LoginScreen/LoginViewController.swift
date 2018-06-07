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
    
    @IBOutlet weak var passTxt: UITextField!
    
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
        
        ChangeLabel(withString: "")
        
        lp = LoginPresenter(withController: self)
        
//        let textField = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 200, 45))
//        textField.placeholder = "Name"
//        textField.title = "Your full name"
//        self.view.addSubview(textField)
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
       // wrongEmail.text = str
    }
    func goToScreen(withScreenName name:String){
        if name == "next"{
            print("PickLoacationViewController")
            let sourceScreenStoryboard = UIStoryboard(name: "SourceScreen", bundle: nil)
            let signup = sourceScreenStoryboard.instantiateViewController(withIdentifier: "PickLoacationViewController")
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
    
}
