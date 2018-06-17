//
//  CreateRequestViewExtension.swift
//  Driveo
//
//  Created by Admin on 6/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

extension CreateRequestView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count-1
        {
            presenter.getPhotoProviderAlert()
        }
    }
    
    
    func showDeletePhotoAlert(forIndex index:Int){
        
        chooseImageProviderAlert = UIAlertController.init(title: "Delete Photo", message:nil, preferredStyle: .actionSheet)
        
        let photoFromGallery:UIAlertAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            self.presenter.deletePhotoConfirmed(atIndex: index)
        })
        
        let cancelAction:UIAlertAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        chooseImageProviderAlert?.addAction(photoFromGallery)
        chooseImageProviderAlert?.addAction(cancelAction)
        
        present(chooseImageProviderAlert!, animated: true, completion: nil)
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
        img.image = images[indexPath.row]
        
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
        imagePickerController = pickerController
        present(imagePickerController!, animated: true, completion: nil)
    }
    
    
    
    func showAlert(withTitle title :String , withMsg msg:String){
        alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        self.present(alert!, animated: true, completion: nil)
        let dismissAlertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert?.addAction(dismissAlertAction)
    }
    
    func goToNextScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func ImageProviderAlert(){
        
        chooseImageProviderAlert = UIAlertController.init(title: "Choose Photo Provider", message:nil, preferredStyle: .actionSheet)
        
        let photoFromGallery:UIAlertAction = UIAlertAction.init(title: "Gallery", style: .default, handler: {(alert: UIAlertAction!) in
            self.presenter.getPhotoFromGallery()
        })
        
        let photoFromCamera:UIAlertAction = UIAlertAction.init(title: "Camera", style: .default, handler: {(alert: UIAlertAction!) in
            self.presenter.getPhotoFromCamera()
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
        images[images.count-1] = image
        images += [UIImage.init(named: "ic_upload_image")!]
        uploadImageCollectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
