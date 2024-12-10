//
//  RequestsNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//
import Foundation
import Alamofire

enum RequestsNetworking {
    case getRequests(dentistID: String)
    case addRequest(dentistID:String,title:String,body:String)
}

extension RequestsNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getRequests(dentistID: let id):
            return "/api/dentist/\(id)/request/"
        case .addRequest(dentistID: let dentistID, title: _, body: _):
            return "/api/dentist/\(dentistID)/request/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRequests:
            return .get
        case .addRequest:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getRequests:
            return .requestPlain
        case .addRequest(dentistID: _, title: let title, body: let body):
            return .requestParameters(parameters: ["title":title,"body":body], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
