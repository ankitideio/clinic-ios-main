//
//  RegisterModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/03/2023.
//

import Foundation
struct PatientResponse: Codable {
    let success: Bool?
    let data: PatientData?
    let message: String?
}

struct PatientData: Codable {
    let id: Int?
}

// MARK: - City
struct City: Codable {
    let label: String
    let value: Int
}

typealias Cities = [City]
