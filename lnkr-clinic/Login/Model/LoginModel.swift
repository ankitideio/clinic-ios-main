//
//  LoginModel.swift
//  LnkrClinic
//
//  Created by Zaki on 05/11/2022.
//

import Foundation

struct LoginModelResponse : Codable {
    let success : Bool?
    let data : UserInfo?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent(UserInfo.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}


//struct UserInfo : Codable {
//    let refresh : String?
//    let access : String?
//    let user : User?
//
//    enum CodingKeys: String, CodingKey {
//
//        case refresh = "refresh"
//        case access = "access"
//        case user = "user"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        refresh = try values.decodeIfPresent(String.self, forKey: .refresh)
//        access = try values.decodeIfPresent(String.self, forKey: .access)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//    }
//
//}


//struct User : Codable {
//    let uuid : String?
//    let dentist : Dentist?
//    let assistant : String?
//    let employee : String?
//    let pharmacist : String?
//    let lab_employee : String?
//    let scan_employee : String?
//    let email : String?
//    let mobile : String?
//    let national_id : String?
//    let activated : Bool?
//    let date_joined : String?
//    let last_login : String?
//    let is_admin : Bool?
//    let is_active : Bool?
//    let is_staff : Bool?
//    let is_superuser : Bool?
//    let groups : [String]?
//    let user_permissions : [String]?
//
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
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
//        dentist = try values.decodeIfPresent(Dentist.self, forKey: .dentist)
//        assistant = try values.decodeIfPresent(String.self, forKey: .assistant)
//        employee = try values.decodeIfPresent(String.self, forKey: .employee)
//        pharmacist = try values.decodeIfPresent(String.self, forKey: .pharmacist)
//        lab_employee = try values.decodeIfPresent(String.self, forKey: .lab_employee)
//        scan_employee = try values.decodeIfPresent(String.self, forKey: .scan_employee)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
//        national_id = try values.decodeIfPresent(String.self, forKey: .national_id)
//        activated = try values.decodeIfPresent(Bool.self, forKey: .activated)
//        date_joined = try values.decodeIfPresent(String.self, forKey: .date_joined)
//        last_login = try values.decodeIfPresent(String.self, forKey: .last_login)
//        is_admin = try values.decodeIfPresent(Bool.self, forKey: .is_admin)
//        is_active = try values.decodeIfPresent(Bool.self, forKey: .is_active)
//        is_staff = try values.decodeIfPresent(Bool.self, forKey: .is_staff)
//        is_superuser = try values.decodeIfPresent(Bool.self, forKey: .is_superuser)
//        groups = try values.decodeIfPresent([String].self, forKey: .groups)
//        user_permissions = try values.decodeIfPresent([String].self, forKey: .user_permissions)
//    }
//
//}

//
//struct Dentist : Codable {
//    let id : Int?
//    let full_name : String?
//    let arabic_name : String?
//    let syndicate_id : String?
//    let qualifications : String?
//    let arabic_qualifications : String?
//    let profile : String?
//    let clinic : [String]?
//    let pricing : Pricing?
//    let patient_discount : String?
//    let lnkr_commission : String?
//    let specialities : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case full_name = "full_name"
//        case arabic_name = "arabic_name"
//        case syndicate_id = "syndicate_id"
//        case qualifications = "qualifications"
//        case arabic_qualifications = "arabic_qualifications"
//        case profile = "profile"
//        case clinic = "clinic"
//        case pricing = "pricing"
//        case patient_discount = "patient_discount"
//        case lnkr_commission = "lnkr_commission"
//        case specialities = "specialities"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
//        arabic_name = try values.decodeIfPresent(String.self, forKey: .arabic_name)
//        syndicate_id = try values.decodeIfPresent(String.self, forKey: .syndicate_id)
//        qualifications = try values.decodeIfPresent(String.self, forKey: .qualifications)
//        arabic_qualifications = try values.decodeIfPresent(String.self, forKey: .arabic_qualifications)
//        profile = try values.decodeIfPresent(String.self, forKey: .profile)
//        clinic = try values.decodeIfPresent([String].self, forKey: .clinic)
//        pricing = try values.decodeIfPresent(Pricing.self, forKey: .pricing)
//        patient_discount = try values.decodeIfPresent(String.self, forKey: .patient_discount)
//        lnkr_commission = try values.decodeIfPresent(String.self, forKey: .lnkr_commission)
//        specialities = try values.decodeIfPresent([String].self, forKey: .specialities)
//    }
//
//}
//
//
//struct Pricing : Codable {
//    let others : Int?
//    let fast_visit : Int?
//    let first_visit : Int?
//    let consultation : Int?
//    let repeat_visit : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case others = "others"
//        case fast_visit = "fast_visit"
//        case first_visit = "first_visit"
//        case consultation = "consultation"
//        case repeat_visit = "repeat_visit"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        others = try values.decodeIfPresent(Int.self, forKey: .others)
//        fast_visit = try values.decodeIfPresent(Int.self, forKey: .fast_visit)
//        first_visit = try values.decodeIfPresent(Int.self, forKey: .first_visit)
//        consultation = try values.decodeIfPresent(Int.self, forKey: .consultation)
//        repeat_visit = try values.decodeIfPresent(Int.self, forKey: .repeat_visit)
//    }
//
//}
