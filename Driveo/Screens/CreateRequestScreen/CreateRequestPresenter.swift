//
//  CreateRequestPresenter.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class CreateRequestPresenter : CreateRequestPresenterProtocol{
    
     var createRequestView:CreateRequestViewProtocol
    
    
    
    func getPhotoFromGallery() {
        
    }
    
    func getPhotoFromCamera() {
        
    }
    
    
   
    
    init(withView view:CreateRequestViewProtocol){
        self.createRequestView = view
    }
    
    
    func createRequestclicked(withTitle title: String, withDescription: String, withImages: [Any]) {
        
    }
    
    func addPhoto(withPhoto photo: Any) {
        
    }
    
    func deletePhoto(withPhoto photo: Any) {
        
    }
    
    func getPhoto() {
       createRequestView.ImageProviderAlert()
    }
    
    func onCreateRequestSuccess() {
        
    }
    
    func onCreateRequestFailure(withError error: String) {
        
    }
    
//    func getPhotoFromGallery() {
//        let controller = UIImagePickerController()
//        controller.delegate = self
//        controller.sourceType = .photoLibrary
//        present(controller, animated: true, completion: nil)
//    }
    
    
//    func getPhotoFromCamera() {
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let picker = UIImagePickerController()
//            picker.delegate = self
//            picker.sourceType = .camera
//            picker.allowsEditing = false
//            picker.sourceType = UIImagePickerControllerSourceType.camera
//            picker.cameraCaptureMode = .photo
//            picker.modalPresentationStyle = .fullScreen
//            present(picker,animated: true,completion: nil)
//        } else {
//            showAlert(withTitle: "No Camera", withMsg: "Sorry, this device has no camera or permission is needed")
//        }
//    }
    
}
