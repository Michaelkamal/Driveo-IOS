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

    private let userOrder=Order.sharedInstance()
    
    lazy var createRequestModel:CreateRequestModelProtocol = CreateRequestModel(withPresenter: self)
    
    var createRequestView:CreateRequestViewProtocol
    
 
    init(withView view:CreateRequestViewProtocol){
        self.createRequestView = view
    }
    
    
    func getPhotoProviderAlert() {
        createRequestView.ImageProviderAlert()
    }
    
    
    func deletePhotoConfirmed(atIndex index: Int) {
        createRequestView.deletePhoto(atIndex: index)
    }
    
    func createRequestclicked(withTitle title: String, withDescription: String, withImages: [UIImage],andWeight weight:Double) {
        
        if title == "" {
            createRequestView.showAlert(withTitle: "Error", withMsg: "Request Should have a title")
        }else  if weight<0,weight>100 {
            createRequestView.showAlert(withTitle: "Error", withMsg: "Weight should be in range 0-100 ")
        }
        else if NetworkDAL.isInternetAvailable() == false {
            createRequestView.showAlert(withTitle: "Error", withMsg: ErrorType.internet.rawValue)
        }else{
            userOrder.details = OrderDetails(withTitle: title,andDescription: withDescription,andImagesArray: withImages)
            userOrder.weight=weight
            createRequestView.goToNextScreen()
        }
        
    }
    

    
    func deletePhotoAlert(withindex index:Int) {
        createRequestView.showDeletePhotoAlert(forIndex: index)
    }
    
    

    //called when request is succes
    func onCreateRequestSuccess(withMessage message:String) {
      createRequestView.dismissLoading()
        if message == "success" {
            createRequestView.goToNextScreen()
        } else {
            createRequestView.showAlert(withTitle: "Error", withMsg: message)
        }
    }
    
    //called when request failure
    func onCreateRequestFailure(withError error: String) {
        createRequestView.dismissLoading()
        createRequestView.showAlert(withTitle: "Error", withMsg: error)
    }
    
    
    
     //create Image Picker Controller for Gallery
    func getPhotoFromGallery() {
        let controller = UIImagePickerController()
        controller.delegate = createRequestView as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        controller.sourceType = .photoLibrary
        createRequestView.showImagePickerController(pickerController: controller)
    }
    
    
    //create Image Picker Controller for Camera
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
