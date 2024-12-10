//
//  AddCardNetworking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 26/12/2022.
//

import Foundation
import Alamofire

enum AddCardNetworking {
    case addCard(dentistID:String,patientID:String,cardNumber:String,pinCode:String)
}

extension AddCardNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .addCard:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .addCard(dentistID: let id, patientID: _, cardNumber: _, pinCode: _):
            return "/api/dentist/\(id)/assignCardToPatient"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addCard:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .addCard(dentistID: _, patientID: let patientID, cardNumber: let cardNum, pinCode: let pinCode):
            return .requestParameters(parameters: ["patient":patientID,"card_number":cardNum,"pin":pinCode], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())"]
        }
    }
}
