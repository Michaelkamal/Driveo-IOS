//
//  VerifyView.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class VerifyView: UIViewController , VerifyViewProtocol, UITextFieldDelegate{
    
    @IBOutlet weak var verificationCodeTextField: SkyFloatingLabelTextField!

    private lazy var presenter:VerifyPresenterProtocol = VerifyPresenter(view: self)
    
     var spinner:UIView?
     var alert:UIAlertController?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCodeTextField.addCharacterSpacing()
        // Do any additional setup after loading the view.
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

    func setCodeErrorLabel(withError error: String) {
        verificationCodeTextField.errorMessage = error
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func goToHomeScreen() {
        let sourceScreenStoryboard = UIStoryboard(name: "SourceScreen", bundle: nil)
        let signup = sourceScreenStoryboard.instantiateViewController(withIdentifier: "PickLoacationViewController")
        self.present(signup, animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String, andMsg msg: String) {
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
        self.present(alert!, animated: true, completion: nil)
    }
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        presenter.sendVerificationCode(withcode: verificationCodeTextField.text!)
    }
    
    
    @IBAction func sendVerifyCodeAction(_ sender: Any) {
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField){
        switch textField.tag {
        case 1:
            presenter.isCodeValid(withCode: textField.text!)
        default: break
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}
