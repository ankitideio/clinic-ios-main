//
//  AssistantModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import Foundation
struct Assistant: Codable {
    let success: Bool?
    let data: [AssistantData]?
    let message: String?
}

// MARK: - AssistantData
struct AssistantData: Codable {
    let id: Int?
    let fullName, clinicName, clinicUUID, nationalID: String?
    let mobile, email: String?
    let dentistID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case clinicName = "clinic_name"
        case clinicUUID = "clinic_uuid"
        case nationalID = "national_id"
        case mobile, email
        case dentistID = "dentist_id"
    }
}
