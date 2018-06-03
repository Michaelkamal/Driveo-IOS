//
//  SignupPresenter.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation


class SignupPresenter : SignupPresenterProtocol{
 
    lazy var signupModel:SignupModelProtocol = SignupModel(presenter: self)
    
    var signupView:SignupViewProtocol
    
    var isPasswordCorrect:Bool=false
    var isConfirmPasswordCorrect:Bool=false
    var isEmailCorrect:Bool=false
    var isPhoneCorrect:Bool=false
    
    
    init(signupView:SignupViewProtocol){
        self.signupView = signupView
    }
    
    var emailErrorLabel:String = "" {
        didSet{
            signupView.setEmailAlertLabel(errorMsg:emailErrorLabel)
            if emailErrorLabel != "" {
                isEmailCorrect = false;
            }else{
                isEmailCorrect = true
            }
        }
    }
    
    var phoneErrorLabel:String = "" {
        didSet{
            signupView.setPhoneAlertLabel(errorMsg:phoneErrorLabel)
            if phoneErrorLabel != "" {
                isPhoneCorrect = false;
            }else{
                isPhoneCorrect = true
            }
        }
    }
    
    var passwordErrorLabel:String = "" {
        didSet{
            signupView.setPasswordAlertLabel(errorMsg:passwordErrorLabel)
            if passwordErrorLabel != "" {
                isPasswordCorrect = false;
            }else{
                isPasswordCorrect = true
            }
        }
    }
    
    var confirmPasswordErrorLabel:String = "" {
        didSet{
            signupView.setConfirmPasswordAlertLabel(errorMsg:confirmPasswordErrorLabel)
            if confirmPasswordErrorLabel != "" {
                isConfirmPasswordCorrect = false;
            }else{
                isConfirmPasswordCorrect = true
            }
        }
    }
    
    
    
    func isPasswordValid(password: String) {
        if (password.matches("^((?!.*\\s)(?=.*[a-zA-Z])(?=.*\\d)).{6,12}$"))
        {
            passwordErrorLabel=""
        }else if password.count<6 || password.count>12{
            passwordErrorLabel="Password length should between 6-12"
        }else{
            passwordErrorLabel="Password should have letter and number"
        }
    }
    
    func isPasswordmatches(password: String, confirmPassword: String) {
        if confirmPassword == password
        {
            confirmPasswordErrorLabel = ""
        }else{
            confirmPasswordErrorLabel  = "password doesn't match"
        }
    }
    func isEmailValid(email: String) {
        if(email.matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"))
        {
            emailErrorLabel=""
        }else{
            emailErrorLabel="Email is not Formatted"
        }
    }
    
    func isPhoneValid(phone: String) {
        if (phone.matches("^01[0-5]\\d{7,8}$"))
        {
            phoneErrorLabel=""
            
        }else{
            phoneErrorLabel="This is not a valid phone number"
        }
    }
    
   func goToVerifyScreen(withToken token:String){
        signupView.dismissLoading()
        let defaults = UserDefaults.standard
        defaults.set(token, forKey :"auth_token")
        defaults.synchronize()
        signupView.goToVerifyScreen()
    }
    
    func alertToShow(withTitle title: String, andMessage msg: String) {
        signupView.dismissLoading()
        signupView.showAlert(withTitle: title, andMessage: msg)
    }
    
    
    func registerclicked(user: User) {
        signupView.showLoading()
        print("Hello from registered \(user.email) \(user.password) + \(user.phone) \(isEmailCorrect) \(isPhoneCorrect) \(isPasswordCorrect) \(isConfirmPasswordCorrect)")
        if !isEmailCorrect || !isPhoneCorrect || !isPasswordCorrect || !isConfirmPasswordCorrect {
            signupView.dismissLoading()
            signupView.showAlert(withTitle: "Error", andMessage: ErrorType.incompleteData.rawValue)
        }else if NetworkDAL.isInternetAvailable() == false {
            signupView.dismissLoading()
            signupView.showNoInternetAlert()
        }else {
            signupModel.registerNewUser(user: user)
        }
    }
    
    
}

