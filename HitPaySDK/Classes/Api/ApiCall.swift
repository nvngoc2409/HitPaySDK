//
// MGConnection.swift.
// NewAPIService.
// 

import Foundation
import SwiftyJSON
import Alamofire

class ApiCall {
    static let shared = ApiCall()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        let tokenDefault = AppManager.getString(AppConstants.PREF_USER_TOKEN)
        let accesstoken: String = tokenDefault != nil ? tokenDefault ?? "" : AppManager.getFromKeychain(AppConstants.KEYCHIN_ACESS_TOKEN) ?? ""
        let refeshToken: String? = tokenDefault != nil ? tokenDefault : AppManager.getFromKeychain(AppConstants.KEYCHIN_ACESS_TOKEN)
        let oAuth2Handler = OAuth2Handler.init(accessToken: accesstoken, refreshToken: refeshToken)
        
        return Session(
            configuration: configuration,
            interceptor: oAuth2Handler)
    }()
    
    func request(_ apiRouter: URLRequestConvertible, completion: @escaping (JsonResult<JSON, String>) -> Void) {
        sessionManager.request(apiRouter).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let res):
                let json = JSON(res)
                print("- result: \(json)")
                if statusCode == 200 || statusCode == 201 || statusCode == 302 {
                    completion(.success(json))
                    return
                }else{
                    _ = json["error"].string
                    if let arrayMsg = json["errors"].dictionary?.first?.value.array, !arrayMsg.isEmpty, let msg = arrayMsg[0].string {
                        completion(.failure(msg))
                        return
                    }
                    let errorMessage = json["message"].string ?? AppConstants.GENERAL_ERROR
                    completion(.failure(errorMessage))
                    return
                }
                
            case .failure(let error):
                print("- error: " + error.localizedDescription)
                completion(.failure(error.localizedDescription))
                return
            }
        }
    }
}

enum JsonResult<T, String> {
    case success(T)
    case failure(String)
}
