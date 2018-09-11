//
//  ProfileDetails.swift
//  DieselApp
//
//  Created by Sreekanth Gudisi on 15/06/18.
//  Copyright © 2018 Narayan. All rights reserved.
//

import Foundation

class OrgProfileWebAPI {

    private static var orgProfileWebAPI : OrgProfileWebAPI? = nil
    static let orgProfileMethodName = "/usr/profile/"
    
    static func instance() -> OrgProfileWebAPI {
        if (orgProfileWebAPI == nil) {
            orgProfileWebAPI = OrgProfileWebAPI()
        }
        return orgProfileWebAPI!
    }
    
    public func userProfileServiceDetails(_ completionHandler: @escaping(UserProfileResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + OrgProfileWebAPI.orgProfileMethodName
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
