//
//  File.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//
import Foundation
import Alamofire

enum PrescriptionDetailsNetworking {
    case getPrescriptionDtails(uuid: String)
}

extension PrescriptionDetailsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getPrescriptionDtails:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getPrescriptionDtails(uuid: let id):
            return "/api/patient/prescription/qr/?uuid=\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPrescriptionDtails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPrescriptionDtails:
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
