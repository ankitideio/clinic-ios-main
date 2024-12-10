//
//  CalenderNetworking.swift
//  lnkr-clinic
//
//  Created by Zaki on 27/11/2022.
//

import Foundation
import Alamofire

enum CalenderNetworking {
    case addVisit(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String )
    
    case addEvent(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String)
    
    case getEvents
    
    case getPatientNames(dentID: String)
}

extension CalenderNetworking: TargetType {
    var baseURL: String {
        switch self {
       
            
        case .addVisit:
            return URLs.baseURL.rawValue
            
            
        case .addEvent:
            return URLs.baseURL.rawValue
            
            
        case .getEvents:
            return URLs.baseURL.rawValue
        
        case .getPatientNames:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        
        case .getPatientNames(dentID: let dentID):
            return "/api/dentist/\(dentID)/patients_search"
            
        case .addVisit(patientID: let patientID, title: let title, type: let type ,visit_status: let visit_status,visit_type: let visit_type,start: let start, end: let end ,cost: let cost):
            return "/api/calendar"
            
            
        case .addEvent(patientID: let patientID, title: let title, type: let type ,visit_status: let visit_status,visit_type: let visit_type,start: let start, end: let end ,cost: let cost):
            return "/api/calendar"
            
        case .getEvents:
            return "/api/calendar"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        
        case .addVisit:
            return .post
           
        case .addEvent:
            return .post
       
        case .getEvents:
            return .get
            
        case .getPatientNames:
            
            return .get
        }
    }
    
    var task: Task {
        switch self {
       
        case .addVisit(patientID: let patientID, title: let title, type: let type ,visit_status: let visit_status,visit_type: let visit_type,start: let start, end: let end ,cost:let cost):
            return .requestParameters(parameters: ["title": title , "patient" : patientID, "type":type , "cost":cost , "visit_status":visit_status , "start":start , "end":end , "visit_type":visit_type], encoding: JSONEncoding.default)
            
            
        case .addEvent(patientID: let patientID, title: let title, type: let type ,visit_status: let visit_status,visit_type: let visit_type,start: let start, end: let end ,cost: let cost):
            return .requestParameters(parameters: ["title": title , "patient" : patientID, "type":type , "cost":cost , "visit_status":visit_status , "start":start , "end":end , "visit_type":visit_type], encoding: JSONEncoding.default)
            
            
        case .getEvents:
            return .requestPlain
            
        case .getPatientNames(dentID: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())" , "Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
