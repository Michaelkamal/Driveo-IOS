//
//  ResetPasswordViewController.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, ResetPasswordViewProtocol {

    var rPP:ResetPasswordPresenterProtocol!
    
    @IBOutlet weak var passwordFld1: UITextField!
    @IBOutlet weak var invalidPassLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var passwordFld2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidPassLbl.isHidden = true
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
        
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
        self.present(loginView!, animated: true, completion: nil)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        if true{
           // wrongMailLbl.isHidden = true
           // fPP.sendLink(withEmail: emailTxt.text!)
            print("matches")
        }
        else{
            ChangeLabel(withString: "Invalid email")
        }
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
