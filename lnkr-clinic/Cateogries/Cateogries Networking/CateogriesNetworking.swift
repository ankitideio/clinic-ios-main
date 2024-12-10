//
//  CateogriesNetworking.swift
//  lnkr-clinic
//
//  Created by Zaki on 26/11/2022.
//

import Foundation
import Alamofire

enum CateogriesNetworking {
    case getCateogries(clinicID : String)
    case addCateogry(clinicID : String,name: String)
    case deleteCateogry(clinicID: String , cateogryID: String)
}

extension CateogriesNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getCateogries:
            return URLs.baseURL.rawValue
            
        case .addCateogry:
            return URLs.baseURL.rawValue
            
        case .deleteCateogry:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getCateogries(clinicID: let id):
            return "/api/clinic/\(id)/category/"
            
            
        case .addCateogry(clinicID: let id, name: _):
            return "/api/clinic/\(id)/category/"
            
        case .deleteCateogry(clinicID: let clinicID, cateogryID: let cateogryID):
            return "/api/clinic/\(clinicID)/category/\(cateogryID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCateogries:
            return .get
            
        case .addCateogry:
            return .post
            
        case .deleteCateogry:
            return .delete
            
        }
    }
    
    var task: Task {
        switch self {
        case .getCateogries:
            return .requestPlain
            
            
        case .addCateogry(clinicID: _ ,name: let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
            
            
        case .deleteCateogry:
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
