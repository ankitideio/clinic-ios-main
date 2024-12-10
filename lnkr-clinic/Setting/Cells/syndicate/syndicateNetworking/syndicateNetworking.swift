//
//  syndicateNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/03/2023.
//

import Foundation
import Alamofire

enum SyndicateNetworking {
    case addSyndicateInfo(params:[String:String])
}

extension SyndicateNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .addSyndicateInfo:
            return "/api/dentist/add_info/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addSyndicateInfo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .addSyndicateInfo(params: let params):
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
