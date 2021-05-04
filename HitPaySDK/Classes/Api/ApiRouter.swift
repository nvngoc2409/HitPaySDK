//
//  CountryApi.swift
//  TemplateProject
//
//  Created by Hoa on 6/28/19.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ApiRouter: URLRequestConvertible {
    case checkEmail(_ email: String)
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .checkEmail: return "stripe/oauth/search"
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .checkEmail: return .post
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .checkEmail(let email):
            return ["email": email]
        }
    }
    
    // MARK: - headers
    private var headers: HTTPHeaders {
        return [:]
    }
    
    // MARK: - EndPoint
    private var array: [[String: Any]]? {
        return nil
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try URLRequest.createRequest(with: path, method, parameters, headers)
    }
}
extension URLRequest {
    static func createRequest(with path: String, _ method: HTTPMethod, _ parameters: Parameters?, _ headers: HTTPHeaders) throws -> URLRequest {
        let url = try AppConstants.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
    
        // setting header
        urlRequest.timeoutInterval = TimeInterval(30)
        urlRequest.headers = headers
        let urlString = urlRequest.url?.absoluteString ?? "No url"
        print("----API SERVICE LOG----")
        print("- url: \(urlString)")
        print("- param: \(parameters ?? [:])")
        print("- method: \(method.rawValue)")
        print("- headers: \(headers)")
        if let parameters = parameters {
            switch method {
            case .get:
                return try URLEncoding.default.encode(urlRequest, with: parameters)
            default:
                return try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        }
        return urlRequest
    }
}
