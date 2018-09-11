
import Foundation

class LoginWebAPI {

    private static var loginWebAPI : LoginWebAPI? = nil
    static let loginMethodName = "/login"
    
    static func instance() -> LoginWebAPI {
        if (loginWebAPI == nil) {
            loginWebAPI = LoginWebAPI()
        }
        return loginWebAPI!
    }
    
    public func loginServiceDetails(_ inputPayload : [String:Any], completionHandler: @escaping(LoginResponse?) -> Void) -> URLSessionDataTask {
        
        let urlBuilder = APIInterface.baseURL + LoginWebAPI.loginMethodName
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
                    let loadProfileResponseModel = try jsonDecoder.decode(LoginResponse.self, from: data)
                    //String.init(data: data, encoding: String.Encoding.utf8)
                    completionHandler(loadProfileResponseModel)
                }
                catch let error as NSError {
                    APIInterface.instance().showError(error: error)
                    completionHandler(nil)
                }
            }
//            else if let error = error {
//                APIInterface.instance().showError(error: error)
//                completionHandler(nil)
//            }
        })
    }
}
