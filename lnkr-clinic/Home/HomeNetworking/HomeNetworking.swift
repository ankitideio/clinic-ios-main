//
//  HomeNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation
import Alamofire

enum HomeNetworking {
    case getHome(dentistID: String)
}

extension HomeNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getHome(dentistID: _):
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getHome(dentistID: let id):
            return "/api/dentist/\(id)/home"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHome(dentistID: _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getHome(dentistID: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
