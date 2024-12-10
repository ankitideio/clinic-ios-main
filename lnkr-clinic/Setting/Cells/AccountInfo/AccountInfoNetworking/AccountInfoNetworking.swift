//
//  AssistantNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//
import Foundation
import Alamofire

enum AccountInfoNetworking {
    case updateAccountInf(params:[String:Any])
}

extension AccountInfoNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .updateAccountInf:
            return "/api/dentist/update_user/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .updateAccountInf:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .updateAccountInf(params: let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
