//
//  DeleteProfileWebAPI.swift
//  LoyaltyApp
//
//  Created by Sreekanth Gudisi on 01/08/18.
//  Copyright © 2018 SimplyFI. All rights reserved.
//

import Foundation

class OrgDeleteProfileWebAPI {
    
    private static var orgDeleteProfileWebAPI : OrgDeleteProfileWebAPI? = nil
    static let orgDeleteProfileMethodName = "/org/deleteProfile"
    
    static func instance() -> OrgDeleteProfileWebAPI {
        if (orgDeleteProfileWebAPI == nil) {
            orgDeleteProfileWebAPI = OrgDeleteProfileWebAPI()
        }
        return orgDeleteProfileWebAPI!
    }
    
    public func userDeleteProfileServiceDetails(_ completionHandler: @escaping(UserDeleteProfileResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + OrgDeleteProfileWebAPI.orgDeleteProfileMethodName
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
