//
//  AddPrescriptionsNetworking.swift
//  lnkr-clinic
//
//  Created by Zaki on 20/11/2022.
//

import Foundation
import Alamofire

enum AddPrescriptionsNetworking {
    case AddPrescriptions
}

extension AddPrescriptionsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .AddPrescriptions:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .AddPrescriptions:
            return "/api/patient/prescription/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .AddPrescriptions:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .AddPrescriptions:
       
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
