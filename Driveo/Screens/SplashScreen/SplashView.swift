//
//  SplashView.swift
//  Driveo
//
//  Created by Admin on 6/7/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class SplashView: UIViewController {

    @IBOutlet weak var splashIcon: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        splashIcon.alpha = 0.0
      //  appName.alpha = 0.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIView.animate(withDuration: 0.3) {
//            self.splashIcon.alpha = 1
//        }
//
        UIView.animate(withDuration: 2.5, delay: 0.3, options: .allowAnimatedContent, animations: {
            self.appName.center.y -= self.view.bounds.height
        }, completion: nil)
        // Do any additional setup after loading the view.
        
        UIView.animate(withDuration: 1.5, delay: 0.3, options: .allowAnimatedContent, animations: {
            self.splashIcon.center.x += self.view.bounds.width
        }, completion: {
            finished in
            let loginStoryBoard = UIStoryboard.init(name: "Login", bundle: nil)
            let loginPage:LoginViewController = loginStoryBoard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
            self.present(loginPage, animated: true, completion: nil)
        })
        // Do any additional setup after loading the view.
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


