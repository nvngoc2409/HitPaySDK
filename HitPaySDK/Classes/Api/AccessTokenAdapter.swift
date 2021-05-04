//
//  AccessTokenAdapter.swift
//  HitPay
//
//  Created by DieuH on 08/02/2020.
//  Copyright © 2020 Ezypayzy. All rights reserved.
//

import Alamofire
import SwiftyJSON

class OAuth2Handler: RequestInterceptor {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        return Session(configuration: configuration)
    }()
    
    private let lock = NSLock()
    
    private let clientID: String = "8fba0aa1-36ce-4423-b3d2-76ad7d731630"
    private let client_secret: String = "W4CkZ32h4bNdOUOrV8L9rAArIt4fmJYgjFGCBDNb"
    private let baseURLString: String = "\(AppConstants.BASE_URL)oauth/token"
    private var accessToken: String
    private var refreshToken: String?
    private var userName: String?
    private var passWord: String?
    
    private var isRefreshing = false
    private var requestsToRetry: [RetryResult] = []
    
    // MARK: - Initialization
    
    public init(accessToken: String, refreshToken: String?) {
        self.accessToken = accessToken
        print(accessToken)
        self.refreshToken = refreshToken
    }
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let urlString = request.url?.absoluteString, urlString.hasPrefix("") {
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        completion(.success(request))
    }
    
    // MARK: - RequestRetrier
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
            
        default:
            
            refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                guard let self = self else { return }
                if let accessToken = accessToken {
                    self.accessToken = accessToken
                    AppManager.setToKeychain(AppConstants.KEYCHIN_ACESS_TOKEN, value: accessToken)
                }
                if let refreshToken = refreshToken {
                    self.refreshToken = refreshToken
                    AppManager.setToKeychain(AppConstants.KEYCHIN_REFRESH_TOKEN, value: refreshToken)
                }
                completion(.retry)
            }
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        let url = URL.init(string: baseURLString)
        var paramaster: Parameters = ["grant_type": "client_credentials",
                                      "client_id": clientID ,
                                      "client_secret": client_secret]
        if let _ = refreshToken {
            paramaster.updateValue("password", forKey: "grant_type")
        } else {
            if let username = userName {
                paramaster.updateValue(username, forKey: "username")
            }
            if let password = passWord {
                paramaster.updateValue(password, forKey: "password")
            }
        }
        session.request(url!,
                        method: .post,
                        parameters: paramaster)
            .responseJSON { [weak self] response in
                guard let self = self, let value = response.value  else { return }
                if let access_token = JSON(value)["access_token"].string {
                    self.accessToken = access_token
                    AppManager.setToKeychain(AppConstants.KEYCHIN_ACESS_TOKEN, value: access_token)
                    if let refreshToken = JSON(value)["refresh_token"].string {
                        self.refreshToken = refreshToken
                        AppManager.setToKeychain(AppConstants.KEYCHIN_REFRESH_TOKEN, value: refreshToken)
                    }
                    completion(true, self.accessToken, self.refreshToken)
                }else{
                    completion(false, nil, nil)
                }
                self.isRefreshing = false
            }
    }
}

