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
        wrongMailLbl.isHidden = true
        fPP = ForgotPassPresenter(withController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitView(_ sender: UIButton) {
        print("ay kalam")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendLink(_ sender: UIButton) {
        if (emailTxt.text?.matches(String.regexes.email.rawValue))!{
            wrongMailLbl.isHidden = true
            fPP.sendLink(withEmail: emailTxt.text!)
            print("matches")
        }
        else{
            ChangeLabel(withString: "Invalid email")
        }
    }
    func goToScreen(withScreenName name: String) {
        
    }
    
    func ChangeLabel(withString str: String) {
        wrongMailLbl.text = str
        wrongMailLbl.isHidden = false
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
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
