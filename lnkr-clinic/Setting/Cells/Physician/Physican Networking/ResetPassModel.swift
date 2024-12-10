//
//  ResetPassModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/12/2022.
//

import Foundation
struct ResetPass:Codable {
    let status: String?
    let code: Int?
    let message: String?
    let data: [String]?
}

struct DentistInfo:Codable {
    let success:Bool?
    let data:dentistData?
    let message:String?
}

struct dentistData:Codable {
    let fullName:String?
    let city:String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case city = "city"
    }
}
