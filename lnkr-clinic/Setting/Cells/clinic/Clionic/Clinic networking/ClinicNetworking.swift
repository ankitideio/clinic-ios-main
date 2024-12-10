//
//  ClinicNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//
import Foundation
import Alamofire

enum ClinicNetworkung {
    case readClinic(clinicID: String)
    case updateClinic(clinicID: String , params:[String:Any])
}

extension ClinicNetworkung: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .readClinic(clinicID: _):
            return "/api/clinic/clinic/"
        case .updateClinic(clinicID: let clinicID , params: _):
            return "/api/clinic/\(clinicID)/update/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .readClinic:
            return .get
        case .updateClinic:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .readClinic:
            return .requestPlain
        case .updateClinic(clinicID: _, params: let params):
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
