//
//  AboutScreen.swift
//  Driveo
//
//  Created by Admin on 6/10/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class AboutScreen: UIViewController {

   
    @IBOutlet weak var aboutText: UILabel!
    
    @IBAction func didTapOnThreeBars(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "auth_token") {
            NetworkDAL.sharedInstance().processReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.about.rawValue, withParser: { (JSON) -> [Any] in
                
                return [JSON.dictionary!["about_us"]!]
            },andHeaders:["Authorization":token],
              onSuccess: { (aboutUs) in
                DispatchQueue.main.async {
                    self.aboutText.text = String(describing: aboutUs.first!)
                }
            }, onFailure: { err  in
                print(err)
            })
        }
   
        
    }

    
    
    
    
    
    

    
    
    @IBAction func backButton(_ sender: Any) {
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

}
