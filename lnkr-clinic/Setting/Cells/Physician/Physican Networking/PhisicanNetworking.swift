//
//  PhisicanNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 02/12/2022.
//

import Foundation
import Alamofire

enum PhysicanNetworking {
    case updateDentist(dentstID: String,dentistDetails:[String:Any])
    case updatePassword(oldPassord:String , newPassword:String)
    case getDentistInfo
    case updateDentistPricing([String:Any])
}

extension PhysicanNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .updateDentist:
            return URLs.baseURL.rawValue
        case .updatePassword:
            return URLs.devURL.rawValue
        case .getDentistInfo:
            return URLs.baseURL.rawValue
        case .updateDentistPricing:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .updateDentist(dentstID: let id, dentistDetails: _):
            print("/api/dentist/\(id)/update/")
            return "/api/dentist/\(id)/update/"
        case .updatePassword:
            return "/api/change-password/"
        case .getDentistInfo:
            return "/api/dentist/info"
        case .updateDentistPricing:
            return "/api/dentist/add_pricing/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .updateDentist:
            return .put
        case .updatePassword:
            return .put
        case .getDentistInfo:
            return .get
        case .updateDentistPricing:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .updateDentist(dentstID: _, dentistDetails: let details):
            return .requestParameters(parameters: details, encoding: JSONEncoding.default)
        case .updatePassword(oldPassord: let oldPassord, newPassword: let newPassword):
            return .requestParameters(parameters: ["old_password":oldPassord , "new_password":newPassword], encoding: JSONEncoding.default)
        case .getDentistInfo:
            return .requestPlain
        case .updateDentistPricing(let params):
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
