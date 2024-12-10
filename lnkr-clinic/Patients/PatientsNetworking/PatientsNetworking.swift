//
//  PatientsNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
import Alamofire

enum PatientNetworking {
    case getPatients(dentistID: String,page:Int)
}

extension PatientNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getPatients:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getPatients(dentistID: let id, page: let page):
            return "/api/dentist/\(id)/\(page)/patients"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPatients:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPatients:
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
