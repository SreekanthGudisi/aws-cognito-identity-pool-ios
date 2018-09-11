//
//  DeleteProfileWebAPI.swift
//  LoyaltyApp
//
//  Created by Sreekanth Gudisi on 01/08/18.
//  Copyright © 2018 SimplyFI. All rights reserved.
//

import Foundation

class UserDeleteProfileWebAPI {
    
    private static var userDeleteProfileWebAPI : UserDeleteProfileWebAPI? = nil
    static let userDeleteProfileMethodName = "/usr/deleteProfile"
    
    static func instance() -> UserDeleteProfileWebAPI {
        if (userDeleteProfileWebAPI == nil) {
            userDeleteProfileWebAPI = UserDeleteProfileWebAPI()
        }
        return userDeleteProfileWebAPI!
    }
    
    public func userDeleteProfileServiceDetails(_ completionHandler: @escaping(UserDeleteProfileResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + UserDeleteProfileWebAPI.userDeleteProfileMethodName
        print(urlBuilder)
        var request = URLRequest(url: URL(string: urlBuilder)!)
        request.httpMethod = "GET"
        
        return APIInterface.instance().executeAuthenticatedWithTokenRequest(request: request, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(UserDeleteProfileResponse.self, from: data)
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
