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
        }
    }
    
    var phoneErrorLabel:String = "" {
        didSet{
            signupView.setPhoneAlertLabel(errorMsg:phoneErrorLabel)
        }
    }
    
    var passwordErrorLabel:String = "" {
        didSet{
            signupView.setPasswordAlertLabel(errorMsg:passwordErrorLabel)
        }
    }
    
    var confirmPasswordErrorLabel:String = "" {
        didSet{
            signupView.setConfirmPasswordAlertLabel(errorMsg:confirmPasswordErrorLabel)
        }
    }

    
    func isPasswordValid(password: String) {
      
        if (password.matches("^((?!.*\\s)(?=.*[a-zA-Z])(?=.*\\d)).{6,12}$"))
        {
            passwordErrorLabel=""
            isPasswordCorrect = true
        }
        else
        {
            if password == ""
            {
                passwordErrorLabel=""
            }
            else if password.count<6 || password.count>12{
                passwordErrorLabel=ErrorType.passwordLength.rawValue
            }else{
                passwordErrorLabel=ErrorType.passwordNumberLetterError.rawValue
            }
            isPasswordCorrect = false
        }
    }
    
    func isPasswordmatches(password: String, confirmPassword: String) {

            if confirmPassword == password
            {
                confirmPasswordErrorLabel = ""
                isConfirmPasswordCorrect = true
            }else{
                if confirmPassword == "" {
                    confirmPasswordErrorLabel = ""
                }else{
                    confirmPasswordErrorLabel  = ErrorType.confirmPassword.rawValue
                }
                isConfirmPasswordCorrect = false
            }
    }
    
    func isEmailValid(email: String) {

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
  
    }
    
    func isPhoneValid(phone: String) {
        
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
        
    }
    
    //save token and tell view to present Verification Screen
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
        //check User Data is valid
        isEmailValid(email: user.email)
        isPhoneValid(phone: user.phone)
        isPasswordValid(password: user.password!)
        isPasswordmatches(password: user.password!, confirmPassword: user.confirmPassword!)
        
        if !isEmailCorrect || !isPhoneCorrect || !isPasswordCorrect || !isConfirmPasswordCorrect {
            signupView.dismissLoading()
            signupView.showAlert(withTitle: ErrorType.errorTitle.rawValue, andMessage: ErrorType.incompleteData.rawValue)
        }else if NetworkDAL.isInternetAvailable() == false {
            signupView.dismissLoading()
            signupView.showAlert(withTitle: ErrorType.errorTitle.rawValue, andMessage: ErrorType.internet.rawValue)
        }else {
            signupModel.registerNewUser(user: user)
        }
    }
}

