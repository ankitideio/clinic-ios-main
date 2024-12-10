//
//  PINCodeNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/12/2022.
//

import Foundation
import Alamofire

enum PINCodeNetworking {
    case findPatient(cardNumber:String,pinCode:String)
}

extension PINCodeNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .findPatient:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .findPatient(cardNumber: let cardNum, pinCode: let pinCode):
            return "/api/patient/card?card_number=\(cardNum)&pincode=\(pinCode)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .findPatient:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .findPatient:
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
