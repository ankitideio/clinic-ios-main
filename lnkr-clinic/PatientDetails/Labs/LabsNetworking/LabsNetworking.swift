//
//  LabsNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//
import Foundation
import Alamofire

enum LabsNetworking {
    case getLabs(patientID: String,page:Int)
}

extension LabsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getLabs:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getLabs(patientID: let id, page: let page):
            return "/api/patient/\(id)/\(page)/labs/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLabs:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getLabs:
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
