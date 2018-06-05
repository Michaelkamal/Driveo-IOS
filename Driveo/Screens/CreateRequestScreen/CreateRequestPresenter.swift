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
    
    lazy var createRequestModel:CreateRequestModelProtocol = CreateRequestModel(withPresenter: self)
    
    var createRequestView:CreateRequestViewProtocol


    func onCreateRequestSuccess(withMessage message: String) {
        
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
    
    func getPhotoFromGallery() {
        let controller = UIImagePickerController()
        controller.delegate = createRequestView as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        controller.sourceType = .photoLibrary
        createRequestView.showImagePickerController(pickerController: controller)
    }
    
    
    func getPhotoFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = createRequestView as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = .camera
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            createRequestView.showImagePickerController(pickerController: picker)
        } else {
            createRequestView.showAlert(withTitle: "No Camera", withMsg: "No Camera or Permission is Needed")
        }
    }
    
}
