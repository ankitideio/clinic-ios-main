//
//  LoginNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
import Alamofire

enum LoginNetworking {
    case login(email:String,password:String)
}

extension LoginNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .login:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/token/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email":email , "password":password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
