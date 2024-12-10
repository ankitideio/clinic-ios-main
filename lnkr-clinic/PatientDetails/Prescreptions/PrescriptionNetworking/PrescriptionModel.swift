//
//  PrescriptionModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 19/11/2022.
//

import Foundation

struct prescriptionBaseModel:Codable {
    let success: Bool?
    let page: Page?
    let data: [Prescription]?
    let message: String?

}

struct Prescription: Codable {
    let uuid, createdDate, insurancee: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case createdDate = "created_date"
        case insurancee
    }
}

struct Insurence: Codable {
    let label: String?
    let value: Int?
}

struct Note: Codable {
    let labs: String?
    let scans: String?
    let medical_supplies: String?
}


