//
//  CreateRequestView.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import BeautifulTextField

class CreateRequestView: UIViewController, CreateRequestViewProtocol {
   
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: BaseBeautifulTextField!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
    @IBOutlet weak var uploadImageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

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

}


extension CreateRequestView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("items gowa elsection")
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("bndeque cell")
        var cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoCell", for: indexPath)
        
        var img:UIImageView = cell.viewWithTag(1) as! UIImageView
        img.image = UIImage.init(named: "ic_upload_image")
        
        
        let height:CGFloat = uploadImageCollectionView.collectionViewLayout.collectionViewContentSize.height
        heightConstraint.constant = height
        self.view.setNeedsLayout()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = UIScreen.main.bounds.size.width
        return CGSize(width: width*0.36 , height: width*0.36)
    }
    
    func showLoading() {
        
    }
    
    func dismissLoading() {
        
    }
    
    func showAlert(withTitle title: String, withMsg msg: String) {
        
    }
    
    func goToNextScreen() {
        
    }
    
    func getNewImage() {
        
    }
    
    func updateImages() {
        
    }
    
}
