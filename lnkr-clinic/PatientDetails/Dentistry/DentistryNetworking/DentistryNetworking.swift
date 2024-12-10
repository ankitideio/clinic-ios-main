//
//  DentistryNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
import Alamofire

enum DentistryNetworking {
    case getDentistry(patientIS: String)
}

extension DentistryNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getDentistry:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getDentistry(patientIS: let id):
            return "/api/patient/treatment_plan/?patient=\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDentistry:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDentistry:
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
