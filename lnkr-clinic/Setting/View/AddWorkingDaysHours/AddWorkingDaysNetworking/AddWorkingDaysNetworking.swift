//
//  AddWorkingDaysNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 07/03/2023.
//
import Foundation
import Alamofire

enum AddWorkingDaysNetworking {
    case AddWorkingDay([String:Any])
}

extension AddWorkingDaysNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .AddWorkingDay:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .AddWorkingDay:
            return "/api/clinic/working_hours_info/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .AddWorkingDay:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .AddWorkingDay(let params):
       
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
