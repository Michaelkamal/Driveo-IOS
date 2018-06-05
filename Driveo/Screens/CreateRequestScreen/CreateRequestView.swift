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
   
    lazy var presenter:CreateRequestPresenterProtocol = CreateRequestPresenter(withView:self)
    var spinner:UIView?
    var alert:UIAlertController?
    var chooseImageProviderAlert:UIAlertController?
    var images:[UIImage] = [UIImage.init(named: "ic_upload_image")!]
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count-1
                {
                    presenter.getPhoto()
                }
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("bndeque cell")
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoCell", for: indexPath)
        
        let img:UIImageView = cell.viewWithTag(1) as! UIImageView
        img.image = UIImage.init(named: "ic_upload_image")
        
        let height:CGFloat = uploadImageCollectionView.collectionViewLayout.collectionViewContentSize.height
        heightConstraint.constant = height
        self.view.setNeedsLayout()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: width*0.36 , height: width*0.36)
    }
    
    func showLoading() {
        spinner = UIViewController.displaySpinner(onView: self.view)
    }
    
    func dismissLoading() {
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func showImagePickerController(pickerController:UIImagePickerController){
        present(pickerController, animated: true, completion: nil)
    }
    
    
    
    func showAlert(withTitle title :String , withMsg msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }
    
    func goToNextScreen() {
        
    }
    
    func getNewImage() {
        
    }
    
    func updateImages() {
        
    }
    
    
    
func ImageProviderAlert(){
    
       chooseImageProviderAlert = UIAlertController.init(title: "Choose Photo", message:"Choose Provider", preferredStyle: .actionSheet)
    
    let photoFromGallery:UIAlertAction = UIAlertAction.init(title: "Gallery", style: .default, handler: {(alert: UIAlertAction!) in
        self.presenter.getPhotoFromGallery()
    })
    
    let photoFromCamera:UIAlertAction = UIAlertAction.init(title: "Camera", style: .default, handler: {(alert: UIAlertAction!) in
        self.presenter.getPhotoFromGallery()
    })
    
    let cancelAction:UIAlertAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
    chooseImageProviderAlert?.addAction(photoFromCamera)
     chooseImageProviderAlert?.addAction(photoFromGallery)
     chooseImageProviderAlert?.addAction(cancelAction)
    
    present(chooseImageProviderAlert!, animated: true, completion: nil)
    }
    
}


extension CreateRequestView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images += [image];
        uploadImageCollectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
