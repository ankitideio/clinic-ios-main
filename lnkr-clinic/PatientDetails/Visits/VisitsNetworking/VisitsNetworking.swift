//
//  VisitsNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
import Alamofire

enum VisitsNetworking {
    case getVisits(patientIS: String,page:Int)
}

extension VisitsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getVisits:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getVisits(patientIS: let id, page: let page):
            return "/api/patient/\(id)/\(page)/visits/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getVisits:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getVisits:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
