//
//  ReportNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//
import Foundation
import Alamofire

enum ReportsNetworking {
    case getReports(patientID: String,page:Int)
    case addReport(patientID: String,title:String,body:String)
}

extension ReportsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getReports:
            return URLs.baseURL.rawValue
        case .addReport:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getReports(patientID: let id, page: let page):
            return "/api/patient/\(id)/\(page)/reports/"
        case .addReport(patientID: let patientID , title: _, body: _):
            return "/api/patient/\(patientID)/reports/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getReports:
            return .get
        case .addReport:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getReports:
            return .requestPlain
        case .addReport(patientID: _, title: let title, body: let body):
            return .requestParameters(parameters: ["title":title,"body":body], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
