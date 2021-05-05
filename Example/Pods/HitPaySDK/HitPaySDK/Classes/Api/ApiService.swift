//
//  CurrencyService.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class ApiService {
    static let shared = ApiService()
    
    func checkEmail(email: String,_ completion: @escaping(JSON?, String?) -> Void) {
        ApiCall.shared.request(ApiRouter.checkEmail(email)) { (respone) in
            switch respone {
            case .success(let json):
                completion(json, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
