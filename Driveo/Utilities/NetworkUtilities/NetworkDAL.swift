//
//  NetworkDAL.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON

enum MsgResponse:String {
    case success = "success"
    case forgotSuccess = "Kindly check your mail to reset your password"
    case notVerified = "sorry this account is not yet verified"
    
}


enum SuffixUrl:String {
    case signup = "authentication/signup"
    case verify = "authentication/verify"
    case resendVerificatoin = "authentication/resendverification"
    case providers = "providers"
    case historyOrders = "orders/showhistory/"
    case upcomingOrders = "orders/showupcoming/"
    case about = "aboutus"
    case login = "authentication/signin"
    case resetPassword = "authentication/resetpassword/?hash="
    case changePassword = "authentication/changepassword"
    case order = "orders"
}


enum ApiBaseUrl:String{
    case googleApi = "https://maps.googleapis.com/"
    case mainApi = "https://driveo.herokuapp.com/api/v1/"
    case testmockAoi = "https://84b52456-526d-4892-a227-4c47f5469182.mock.pstmn.io"
}

public class NetworkDAL{
    
    static func isInternetAvailable() -> Bool {
        return (NetworkReachabilityManager()?.isReachable)!
    }
    
    static internal func sharedInstance () ->(NetworkDAL)
    {
        struct Singleton {
            static let instance = NetworkDAL();
        }
        
        return Singleton.instance;
        
    }
    private init(){}
    
    internal func processPostReq(
        withBaseUrl baseUrl:ApiBaseUrl,
        andUrlSuffix urlSuffix:String,
        andParameters param: Parameters,
        onSuccess: @escaping (_ :Data)->Void,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        , headers:HTTPHeaders? = nil)-> Void{
        
        Alamofire.request(baseUrl.rawValue+urlSuffix,method: .post, parameters: param, headers:headers).validate().responseJSON { response  in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data);
                
                print("***URL**** "+urlSuffix)
                print("-------*-*-*-----******------///////-------********-----------------")
                print(jsonData)
                onSuccess(response.data!);
                
            case .failure :
                //onFailure(.internet)
                print("-------*-*-*-----****failiure**------///////-------********-----------------")
                print(response)
                
                print(response.result)
                onFailure(ErrorType.internet)
            }
        }
        
    }
    
    
    
    
    internal func processReq(
        withBaseUrl baseUrl:ApiBaseUrl,
        andUrlSuffix urlSuffix:String,
        withParser parser: @escaping (_ JSON:JSON) ->[Any],
        andHeaders headers:HTTPHeaders? = nil,
        onSuccess: @escaping (_ :[Any])->Void,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        )-> Void{
         Alamofire.request(baseUrl.rawValue+urlSuffix, method: .get, parameters: nil, headers: headers).validate().responseJSON { response  in
                        switch response.result {
                        case .success(let data):
                            let jsonData = JSON(data);
                            print(response.request!.url!.absoluteString)
                            print(data)
                            print(jsonData)
                            onSuccess(parser(jsonData));
                        case .failure :
                            onFailure(.internet)
                        }
                    }
        
    }
    
    
    
    internal func processPatchReq(
        withBaseUrl baseUrl:ApiBaseUrl,
        andUrlSuffix urlSuffix:String,
        andParameters param: Parameters,
        onSuccess: @escaping (_ :Data)->Void,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        , headers:HTTPHeaders? = nil)-> Void{
        
        Alamofire.request(baseUrl.rawValue+urlSuffix,method: .patch, parameters: param, headers:headers).validate().responseJSON { response  in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data);
                
                print("***URL**** "+urlSuffix)
                print("-------*-*-*-----******------///////-------********-----------------")
                print(jsonData)
                onSuccess(response.data!);
                
            case .failure :
                //onFailure(.internet)
                print("-------*-*-*-----****failiure**------///////-------********-----------------")
                print(response)
                
                print(response.result)
                onFailure(ErrorType.internet)
            }
        }}
    
    
    internal func processPostUploadMultiPart(
        withBaseUrl baseUrl:ApiBaseUrl,
        andUrlSuffix urlSuffix:String,
        andParameters param: [String:Any],
        onSuccess: @escaping (_ :DataResponse<Any>)->Void,onProgress:@escaping(_ :Double)->Void ,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        , headers:HTTPHeaders? = nil,andImages images:[UIImage] = [])-> Void{
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in param {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(String(images.count).data(using: String.Encoding.utf8)!, withName: "images_count")
            if images.count > 0 {
                for i in 0..<images.count{
                    let image = images[i]
                    let imgData = UIImageJPEGRepresentation(image, 0.9)!
                    multipartFormData.append(imgData, withName: "images[]",fileName:"images\(i+1).jpg", mimeType: "image/jpg")
                }
            }
            
            
        }, usingThreshold: UInt64.init(), to: String("\(baseUrl.rawValue)\(urlSuffix)"), method: .post, headers: headers, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    onProgress(progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    if let value = response.result.value as? [String:Any]{
                        if ( value["message"] as! String == MsgResponse.success.rawValue)
                    {
                       onSuccess(response)
                        }else{
                    onFailure(ErrorType.internet)
                    }
                    }}
            case .failure(let encodingError):
                onFailure(ErrorType.internet)
            }
        })
        
       
       
    }
}
