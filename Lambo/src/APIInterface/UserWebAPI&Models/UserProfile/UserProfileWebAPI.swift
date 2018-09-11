//
//  ProfileDetails.swift
//  DieselApp
//
//  Created by Sreekanth Gudisi on 15/06/18.
//  Copyright © 2018 Narayan. All rights reserved.
//

import Foundation

class UserProfileWebAPI {

    private static var userProfileWebAPI : UserProfileWebAPI? = nil
    static let userProfileMethodName = "/usr/profile/"
    
    static func instance() -> UserProfileWebAPI {
        if (userProfileWebAPI == nil) {
            userProfileWebAPI = UserProfileWebAPI()
        }
        return userProfileWebAPI!
    }
    
    public func userProfileServiceDetails(_ completionHandler: @escaping(UserProfileResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + UserProfileWebAPI.userProfileMethodName
        print(urlBuilder)
        var request = URLRequest(url: URL(string: urlBuilder)!)
        request.httpMethod = "GET"
        
        return APIInterface.instance().executeAuthenticatedWithTokenRequest(request: request, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(UserProfileResponse.self, from: data)
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
