//
//  ScansNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
import Alamofire

enum ScansNetworking {
    case getScans(patientID: String,page:Int)
}

extension ScansNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getScans:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getScans(patientID: let id, page: let page):
            return "/api/patient/\(id)/\(page)/scans/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getScans:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getScans:
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
