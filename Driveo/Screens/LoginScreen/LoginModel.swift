//
//  LoginModel.swift
//  Driveo
//
//  Created by Admin on 6/2/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class LoginModel : LoginModelProtocol{
    
    var lp:LoginPresenterProtocol
    
    init(withPresenter p:LoginPresenterProtocol) {
        lp=p
    }
    
    func sendRequest(withUserName name:String,andPassword pass:String){
        let networkObj:NetworkDAL = NetworkDAL.sharedInstance()
        let user = User(email: name, phone: "", password: pass)
        let params = user.getUserDataInDictionary()
        networkObj.processPostReq(withBaseUrl: .mainApi, andUrlSuffix: SuffixUrl.login.rawValue, andParameters: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func onSuccess(_ response:Data) -> Void{
        print(response)
        do{
            let response = try JSONDecoder().decode(SigninResult.self, from: response)
            let msg:String = response.message
            if  msg == MsgResponse.success.rawValue {
                let defaults = UserDefaults.standard
                print(response.auth_token)
                defaults.set(response.auth_token, forKey :"auth_token")
                defaults.set(true, forKey :"verified")
                defaults.synchronize()
                lp.loginSuccess(page: "next")
                UserDAL.sharedInstance().saveUser(user: response.user!)
            }else if msg == MsgResponse.notVerified.rawValue {
                lp.loginSuccess(page: "verification")
                
            }else{
                lp.loginFailure(message: msg)
            }
        }
        catch {
            print("catch")
            print(ErrorType.parse.rawValue)
            lp.loginFailure(message: "Connection error")
        }
    }
    func onFailure(_ networkError:ErrorType) -> Void{
        lp.loginFailure(message: "Connection Error")
    }
    
    
}



