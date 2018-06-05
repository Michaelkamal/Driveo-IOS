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

enum ApiBaseUrl:String{
    case googleApi = "https://maps.googleapis.com/"
    case mainApi = "https://driveo.herokuapp.com/"
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
        onSuccess: @escaping (_ :Any)->Void,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        , headers:HTTPHeaders? = nil)-> Void{
        
        Alamofire.request(baseUrl.rawValue+urlSuffix,method: .post, parameters: param, headers:headers).validate().responseJSON { response  in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data);
                print("***URL**** "+urlSuffix)
                //driveo://driveo.heroku.com/reset_password/?hash=eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNTI4MjQyNjAzfQ.f7880ZL6hQPweP-bQiCcu6_kGOTMEtzKP4osywYFDp0
                print("-------*-*-*-----*******------///////-------********-----------------")
                print(jsonData)
                onSuccess(data);
                
            case .failure :
                //onFailure(.internet)
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
        onSuccess: @escaping (_ :[Any])->Void,
        onFailure:  @escaping (_ networkError:ErrorType)->Void
        )-> Void{
        
                    Alamofire.request(baseUrl.rawValue+urlSuffix).validate().responseJSON { response  in
                        switch response.result {
                        case .success(let data):
                            let jsonData = JSON(data);
                            print(response.request!.url!.absoluteString)
                            onSuccess(parser(jsonData));
                        case .failure :
                            onFailure(.internet)
                        }
                    }
        
    }
    
    
    
}
