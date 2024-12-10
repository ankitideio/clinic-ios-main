//
//  AddPatientNetworking.swift
//  lnkr-clinic
//
//  Created by Zaki on 19/11/2022.
//

import Foundation
import Alamofire

enum AddPatientNetworking {
    case AddPatient(fullName: String, birthdate:String , mobile: String , nationalID: String , gender: Int , pinCode: String , bloodType: String , drugAllergy: String , foodAllergy: String)
}

extension AddPatientNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .AddPatient:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .AddPatient:
            return "/api/patient/register_patient/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .AddPatient:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .AddPatient(fullName: let fullName, birthdate: let birthdate, mobile: let mobile, nationalID: let nationalID, gender: let gender, pinCode: let pinCode, bloodType: let bloodType, drugAllergy: let drugAllergy, foodAllergy: let foodAllergy):
       
            return .requestParameters(parameters: ["full_name":fullName , "birthdate":birthdate , "mobile":mobile , "national_id":nationalID , "gender":gender , "pin_code":pinCode , "blood_type":bloodType , "drug_allergy":drugAllergy , "food_allergy":foodAllergy], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"application/json","Accept":"application/json"]
        }
    }
}
