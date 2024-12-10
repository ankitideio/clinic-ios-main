//
//  PersonalOnfoModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation

struct PersonaLInfoBase:Codable {
    var success:Bool?
    var data:PersonalInfo?
    var message:String?
}
struct PersonalInfo: Codable {
    let fullName, birthdate, gender: String?
    let age: Int?
    let profession: String?
    let hasCard: Bool?
    let cardNumber: String?
    let pinCode: String?
    let homeAddress, workAddress: String?
    let mobile, nationalID, email: String?
    let profilePic: String?
    let bloodType, drugAllergy, foodAllergy: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case birthdate, gender, age, profession
        case hasCard = "has_card"
        case cardNumber = "card_number"
        case pinCode = "pin_code"
        case homeAddress = "home_address"
        case workAddress = "work_address"
        case mobile
        case nationalID = "national_id"
        case email
        case profilePic = "profile_pic"
        case bloodType = "blood_type"
        case drugAllergy = "drug_allergy"
        case foodAllergy = "food_allergy"
    }
}
