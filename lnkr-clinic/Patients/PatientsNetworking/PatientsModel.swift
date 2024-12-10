//
//  PatientsModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation

struct PatientBaseModel: Codable {
    let success: Bool?
    let page: Page?
    let data: [Patient]?
    let message: String?
}

struct Patient: Codable {
    let id: Int?
    let fullName, birthdate, gender, patientMobile: String?
    let profilePic: String?
    let cardNumber: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case birthdate, gender
        case patientMobile = "patient_mobile"
        case profilePic = "profile_pic"
        case cardNumber = "card_number"
    }
}
