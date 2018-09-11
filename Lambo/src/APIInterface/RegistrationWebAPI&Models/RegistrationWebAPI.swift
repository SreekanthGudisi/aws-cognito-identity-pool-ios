//
//  ProfileDetails.swift
//  DieselApp
//
//  Created by Sreekanth Gudisi on 15/06/18.
//  Copyright © 2018 Narayan. All rights reserved.
//

import Foundation

class RegistrationWebAPI {

    private static var registrationWebAPI : RegistrationWebAPI? = nil
    static let registrationMethodName = "/register"
    
    static func instance() -> RegistrationWebAPI {
        if (registrationWebAPI == nil) {
            registrationWebAPI = RegistrationWebAPI()
        }
        return registrationWebAPI!
    }
    
    public func registerServiceDetails(_ inputPayload : [String:Any], completionHandler: @escaping(RegistrationResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + RegistrationWebAPI.registrationMethodName
        print(urlBuilder)
        var request = URLRequest(url: URL(string: urlBuilder)!)
        request.httpBody = APIInterface.instance().convertToJson(data: inputPayload)
        request.httpMethod = "POST"
        
        return APIInterface.instance().executeAuthenticatedWithOutTokenRequest(request: request, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    //let url = Bundle.main.url(forResource:"contents", withExtension: "json")
                    //let fileData = try Data(contentsOf:url!)
                    let jsonDecoder = JSONDecoder()
                    //jsonDecoder.dateDecodingStrategy = .formatted(APIInterface.dateFormatterWithTime)
                    let loadProfileResponseModel = try jsonDecoder.decode(RegistrationResponse.self, from: data)
                    //String.init(data: data, encoding: String.Encoding.utf8)
                    completionHandler(loadProfileResponseModel)
                }
                catch let error as NSError {
                    APIInterface.instance().showError(error: error)
                    completionHandler(nil)
                }
            } else if let error = error {
                APIInterface.instance().showError(error: error)
                completionHandler(nil)
            }
        })
    }
}
