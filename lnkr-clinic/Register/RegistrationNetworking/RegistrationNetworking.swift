//
//  RegistrationNetworking.swift
//  lnkr-patient
//
//  Created by MohamedNajeh on 22/01/2023.
//

import Foundation
import Alamofire

enum RegisterNetworking {
    case register([String:Any])
    case getCities
}

extension RegisterNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .register:
            return URLs.baseURL.rawValue
        case .getCities:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return "/api/dentist/signup"
        case .getCities:
            return "/api/assets/city"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .getCities:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .register(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getCities:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .register:
            return ["Content-Type":"application/json","Accept":"application/json"]
        case .getCities:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
