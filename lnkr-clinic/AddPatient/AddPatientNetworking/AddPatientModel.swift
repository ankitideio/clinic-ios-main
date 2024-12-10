//
//  AddPatientModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 19/11/2022.
//

import Foundation
struct AddPatientUserInfo : Codable{
    let data : PatientInfo?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
    }
}

struct PatientInfo : Codable {
    let id : Int?
    let fullName , birthdate , gender , company , pinCode , address , homeAddress : String?
    
    
    
//    enum CodingKeys: String, CodingKey {
//
//        case uuid = "uuid"
//        case dentist = "dentist"
//        case assistant = "assistant"
//        case employee = "employee"
//        case pharmacist = "pharmacist"
//        case lab_employee = "lab_employee"
//        case scan_employee = "scan_employee"
//        case email = "email"
//        case mobile = "mobile"
//        case national_id = "national_id"
//        case activated = "activated"
//        case date_joined = "date_joined"
//        case last_login = "last_login"
//        case is_admin = "is_admin"
//        case is_active = "is_active"
//        case is_staff = "is_staff"
//        case is_superuser = "is_superuser"
//        case groups = "groups"
//        case user_permissions = "user_permissions"
//    }
}
