//
//  PINCodeModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/12/2022.
//

import Foundation
struct PINCode: Codable {
    let success: Bool?
    let data: FoundedPatient?
    let message: String?
}

// MARK: - FoundedPatient
struct FoundedPatient: Codable {
    let patientID: Int?
    enum CodingKeys: String, CodingKey {
        case patientID = "patient_id"
    }
}
