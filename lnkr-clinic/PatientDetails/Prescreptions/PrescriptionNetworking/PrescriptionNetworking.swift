//
//  PrescriptionNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 19/11/2022.
//
import Foundation
import Alamofire

enum PrescriptionNetworking {
    case getPrescriptions(patientID: String,page:Int)
    case getInsurences
    case getDesease
    case addPrescription(prescription:[String:Any])
}

extension PrescriptionNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getPrescriptions(patientID: let id, page: let page):
            return "/api/patient/\(page)/prescription/?patient=\(id)"
        case .getInsurences:
            return "/api/assets/insurance"
        case .getDesease:
            return "/api/assets/patient_diagnostic"
        case .addPrescription:
            return "/api/patient/prescription/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPrescriptions:
            return .get
        case .getInsurences:
            return .get
        case .getDesease:
            return .get
        case .addPrescription:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getPrescriptions:
            return .requestPlain
        case .getInsurences:
            return .requestPlain
        case .getDesease:
            return .requestPlain
        case .addPrescription(prescription: let prescription):
            return .requestParameters(parameters: prescription, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
