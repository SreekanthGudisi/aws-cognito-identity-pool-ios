//
//  UserTranferWebAPI.swift
//  LoyaltyApp
//
//  Created by Sreekanth Gudisi on 01/08/18.
//  Copyright © 2018 SimplyFI. All rights reserved.
//


import Foundation

class UserTranferWebAPI {
    
    private static var userTranferWebAPI : UserTranferWebAPI? = nil
    static let userTranferMethodName = "/usr/transfer"
    
    static func instance() -> UserTranferWebAPI {
        if (userTranferWebAPI == nil) {
            userTranferWebAPI = UserTranferWebAPI()
        }
        return userTranferWebAPI!
    }
    
    public func userTranferServiceDetails(_ inputPayload : [String:Any], completionHandler: @escaping(LoginResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + UserTranferWebAPI.userTranferMethodName
        print(urlBuilder)
        var request = URLRequest(url: URL(string: urlBuilder)!)
        request.httpBody = APIInterface.instance().convertToJson(data: inputPayload)
        request.httpMethod = "POST"
        
        return APIInterface.instance().executeAuthenticatedWithTokenRequest(request: request, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(LoginResponse.self, from: data)
                    completionHandler(response)
                }
                catch let error as NSError {
                    APIInterface.instance().showError(error: error)
                    completionHandler(nil)
                }
                
            }
        })
    }
}

