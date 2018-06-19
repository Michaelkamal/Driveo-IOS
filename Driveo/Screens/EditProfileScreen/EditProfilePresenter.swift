//
//  SignupPresenter.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class EditProfilePresenter {
    
    private var controller:UIViewController!
    private var view:EditProfileProtocol!
    private lazy var model = NetworkDAL.sharedInstance()
    let savedUser=UserDAL.sharedInstance().getUser()
    
    init(withController controller:UIViewController) {
        self.controller=controller
        view=controller as! EditProfileProtocol
    }
    var isEmailCorrect:Bool=false
    var isPhoneCorrect:Bool=false
    
  
    
    var emailErrorLabel:String = "" {
        didSet{
            view.setEmailAlertLabel(errorMsg:emailErrorLabel)
        }
    }
    
    var phoneErrorLabel:String = "" {
        didSet{
            view.setPhoneAlertLabel(errorMsg:phoneErrorLabel)
        }
    }
    
    func isEmailValid(email: String) {

        if(email != savedUser?.email){
        if (email.matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"))
        {
            emailErrorLabel=""
            isEmailCorrect = true
        }
        else
        {
                if email == ""
                {
                    emailErrorLabel=""
                    
                }
                else {
                    emailErrorLabel=ErrorType.invalidEmail.rawValue
                }
            isEmailCorrect = false
        }
  
        }else
        {
            emailErrorLabel=ErrorType.invalidEmail.rawValue
            isEmailCorrect = false
        }
    }
    
    func isPhoneValid(phone: String) {
        if(phone != savedUser?.phone){
            if (phone.matches("^01[0-5]\\d{7,8}$"))
            {
                phoneErrorLabel=""
                isPhoneCorrect = true
            }
            else {
                        if phone == ""{
                             phoneErrorLabel=""
                            
                        }else {
                             phoneErrorLabel=ErrorType.invalidPhoneNumber.rawValue
                        }
                isPhoneCorrect = false
             }
        }else{
         phoneErrorLabel=ErrorType.invalidPhoneNumber.rawValue
            isPhoneCorrect = false
        }
    }
    
    //save token and tell view to present Verification Screen
   func goToVerifyScreen(withToken token:String){
        view.dismissLoading()
        let defaults = UserDefaults.standard
        defaults.set(token, forKey :"auth_token")
        defaults.synchronize()
        view.presentToNextScreen()
    }
    
    func alertToShow(withTitle title: String, andMessage msg: String) {
        view.dismissLoading()
        view.showAlert(ofError:ErrorType.errorTitle)
    }
    
    
    func editUser(user: User) {
        view.showLoading()
        //check User Data is valid
        isEmailValid(email: user.email)
        isPhoneValid(phone: user.phone)
        if !isEmailCorrect || !isPhoneCorrect   {
            view.dismissLoading()
            view.showAlert(ofError: ErrorType.incompleteData)
        }else if NetworkDAL.isInternetAvailable() == false {
            view.dismissLoading()
            view.showAlert(ofError: ErrorType.internet)
        }else {
            let defaults = UserDefaults.standard
            if let token = defaults.string(forKey: "auth_token"){
                model.processPutReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.update.rawValue, andParameters: ["email":user.email,"phone":user.phone], onSuccess: { (data) in
                    self.view.dismissLoading()
                    self.view.presentToNextScreen()
                    if var savedUser=UserDAL.sharedInstance().getUser(){
                        savedUser.email=user.email
                        savedUser.phone=user.phone
                        UserDAL.sharedInstance().saveUser(user: savedUser)
                    }
                    
                }, onFailure: view.showAlert, headers: ["Authorization":token])
            }
            
        }
    }
}

