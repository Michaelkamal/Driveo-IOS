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
        wrongEmail.text=""
        if (emailTxt.text?.matches(String((String.regexes.email).rawValue)))! {
            lp.login(withUserName: emailTxt.text!, andPassword: passTxt.text!)
            showLoading()
        }
        else{
            wrongEmail.text = "Invalid E-mail"
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
        
        
        wrongEmail.text=""
        
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
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
}
