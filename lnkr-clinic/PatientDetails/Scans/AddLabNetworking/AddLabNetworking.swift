//
//  AddScansNetworking.swift
//  lnkr-clinic
//
//  Created by Zaki on 20/11/2022.
//

import Foundation
import Alamofire

enum AddLabNetworking {
    case AddLab(labResult: String, labName:String )
}

extension AddLabNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .AddLab:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .AddLab:
            return "/api/patient/2342/scans/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .AddLab:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .AddLab(labResult: let labResult, labName: let labName):
       
            return .requestParameters(parameters: ["lab_result":labResult , "lab_name":labName ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
