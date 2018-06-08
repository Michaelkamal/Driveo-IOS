//
//  ResetPasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ResetPasswordViewController: UIViewController, ResetPasswordViewProtocol {
    
    var spinner:UIView!
    var rPP:ResetPasswordPresenterProtocol!
    
    @IBOutlet weak var passwordFld1: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordFld2: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        rPP = ResetPasswordPresenter(withController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToScreen(withScreenName name: String) {
        
    }
    
    func ChangeLabel(ofField field: Int ,withString str: String) {
        switch field {
        case 2:
            passwordFld2.errorMessage = str
        default:
            passwordFld1.errorMessage = str

        }
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
        self.present(loginView!, animated: true, completion: nil)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        if passwordFld1.text! == passwordFld2.text! && true{
            rPP.resetPassword(withPassword: passwordFld1.text!)
            print("matches")
            showLoading()
        }
        else if true{
            ChangeLabel(ofField: 1, withString: "Invalid password")
        }
        else if passwordFld1.text! != passwordFld2.text! {
            ChangeLabel(ofField: 2, withString: "Doesn't match")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
