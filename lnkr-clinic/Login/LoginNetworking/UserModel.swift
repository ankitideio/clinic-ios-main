//
//  UserModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
struct UserInfo : Codable {
    let refresh : String?
    let access : String?
    let user : User?
    
    enum CodingKeys: String, CodingKey {
        
        case refresh = "refresh"
        case access = "access"
        case user = "user"
    }
}


struct User : Codable {
    let uuid : String?
    let dentist : Dentist?
    let assistant : String?
    let employee : String?
    let pharmacist : String?
    let lab_employee : String?
    let scan_employee : String?
    let email : String?
    let mobile : String?
    let national_id : String?
    let activated : Bool?
    let date_joined : String?
    let last_login : String?
    let is_admin : Bool?
    let is_active : Bool?
    let is_staff : Bool?
    let is_superuser : Bool?
    let groups : [String]?
    let user_permissions : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case uuid = "uuid"
        case dentist = "dentist"
        case assistant = "assistant"
        case employee = "employee"
        case pharmacist = "pharmacist"
        case lab_employee = "lab_employee"
        case scan_employee = "scan_employee"
        case email = "email"
        case mobile = "mobile"
        case national_id = "national_id"
        case activated = "activated"
        case date_joined = "date_joined"
        case last_login = "last_login"
        case is_admin = "is_admin"
        case is_active = "is_active"
        case is_staff = "is_staff"
        case is_superuser = "is_superuser"
        case groups = "groups"
        case user_permissions = "user_permissions"
    }
}


struct Dentist : Codable {
    let id : Int?
    let full_name : String?
    let arabic_name : String?
    let syndicate_id : String?
    let qualifications : String?
    let arabic_qualifications : String?
    let profile : String?
    let clinic : [String]?
    let pricing : Pricing?
    let patient_discount : String?
    let lnkr_commission : String?
    let specialities : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case full_name = "full_name"
        case arabic_name = "arabic_name"
        case syndicate_id = "syndicate_id"
        case qualifications = "qualifications"
        case arabic_qualifications = "arabic_qualifications"
        case profile = "profile"
        case clinic = "clinic"
        case pricing = "pricing"
        case patient_discount = "patient_discount"
        case lnkr_commission = "lnkr_commission"
        case specialities = "specialities"
    }
}


struct Pricing : Codable {
    let others : Int?
    let fast_visit : Int?
    let first_visit : Int?
    let consultation : Int?
    let repeat_visit : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case others = "others"
        case fast_visit = "fast_visit"
        case first_visit = "first_visit"
        case consultation = "consultation"
        case repeat_visit = "repeat_visit"
    }
}


