//
//  Accounting Networking.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/12/2022.
//

import Foundation
import Alamofire

enum AccountingNetwqorking {
    case getAccounting(dentistID:Int)
}

extension AccountingNetwqorking: TargetType {
    var baseURL: String {
        switch self {
        case .getAccounting:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getAccounting(dentistID: let id):
            return "/api/dentist/\(id)/accounting"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAccounting:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAccounting:
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
