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
    
 
    init(withView view:CreateRequestViewProtocol){
        self.createRequestView = view
    }
    
    
    func createRequestclicked(withTitle title: String, withDescription: String, withImages: [UIImage]) {
        
        if title == "" {
            createRequestView.showAlert(withTitle: "Erroe", withMsg: "Request Should have a title")
        }
        else if NetworkDAL.isInternetAvailable() == false {
            createRequestView.showAlert(withTitle: "Error", withMsg: ErrorType.internet.rawValue)
        }else{
            createRequestView.showLoading()
            createRequestModel.sendCreateRequest(withTitle: title, withDescription: withDescription, withImages: withImages, from: "76576576", to: "65465465", provider_id: "1", payment_method: "hsh")
        }
        
    }
    
    func addPhoto(withPhoto photo: Any) {
        
    }
    
    func deletePhoto(withPhoto photo: Any) {
        
    }
    
    
    func getPhoto() {
       createRequestView.ImageProviderAlert()
    }
    
    func onCreateRequestSuccess(withMessage message:String) {
      createRequestView.dismissLoading()
        if message == "success" {
            createRequestView.goToNextScreen()
        } else {
            createRequestView.showAlert(withTitle: "Error", withMsg: message)
        }
        
    }
    
    func onCreateRequestFailure(withError error: String) {
        createRequestView.dismissLoading()
        createRequestView.showAlert(withTitle: "Error", withMsg: error)
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
