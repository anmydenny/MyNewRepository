//
//  WebServiceHandler.swift
//  Ecomerse
//
//  Created by anmy on 24/02/23.
//

import Foundation
import Alamofire

class WebHandler {
    
    static let sharedInstance = WebHandler();
    
    var headers: HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ];
    // returns data and error in completionHandler
    func parseData(method:HTTPMethod,api:String,params:[String:Any]?,encoding:ParameterEncoding = JSONEncoding.default,completionHandler:@escaping(Data?,Error?) -> Void){
        let url = "https://run.mocky.io/v3/" + api
        print(url)
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseData { (responseData) in
            if responseData.error == nil {
                if let data = responseData.data {
                    completionHandler(data,nil)
                    return
                }
            }
            completionHandler(nil,responseData.error)
        }
    }
}
