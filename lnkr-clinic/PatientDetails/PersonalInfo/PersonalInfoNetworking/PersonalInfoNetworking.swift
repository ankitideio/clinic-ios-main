//
//  PersonalInfoNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
import Alamofire

enum PersonalInfoNetworking {
    case getPatientOnfo(patientID: Int)
    case updatePatient(patientID:String,patientDetils:[String:String])
}

extension PersonalInfoNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getPatientOnfo(patientID: let id):
            print("/api/patient/\(id)")
            return "/api/patient/\(id)/"
        case .updatePatient(patientID: let id, patientDetils: _):
            return "/api/patient/\(id)/update/"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPatientOnfo:
            return .get
        case .updatePatient:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getPatientOnfo:
            return .requestPlain
        case .updatePatient(patientID: _, patientDetils: let details):
            return .requestParameters(parameters: details, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
