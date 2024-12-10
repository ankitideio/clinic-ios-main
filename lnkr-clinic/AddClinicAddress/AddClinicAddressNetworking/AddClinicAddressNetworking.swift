//
//  AddClinicAddressNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/03/2023.
//

import Foundation
import Alamofire

enum AddClinicAddressNetworking {
    case addAddress(params:[String:Any])
}

extension AddClinicAddressNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .addAddress:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .addAddress:
            return "/api/clinic/address_info/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addAddress:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .addAddress(let params):
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
