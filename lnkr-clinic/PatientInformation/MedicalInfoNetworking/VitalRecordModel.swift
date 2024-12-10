//
//  VitalRecordModel.swift
//  lnkr-clinic
//
//  Created by meet sharma on 29/04/23.
//

import Foundation

// MARK: - VitalRecordModel
struct VitalRecordModel: Codable {
    let success: Bool?
    let page: InfoPage?
    let data: [VitalRecordData]?
    let message: String?
}

// MARK: - VitalRecordData
struct VitalRecordData: Codable {
    let uuid, createdDate, weight, height: String?
    let bmi: Double?
    let bloodPressure, sugarLevel, temperature, oxygenSaturation: String?
    let race, pulse: String?
    var date: String?
    enum CodingKeys: String, CodingKey {
        case uuid
        case createdDate = "created_date"
        case weight, height
        case bmi = "BMI"
        case bloodPressure = "blood_pressure"
        case sugarLevel = "sugar_level"
        case temperature
        case oxygenSaturation = "oxygen_saturation"
        case race, pulse
        case date
    }
}

// MARK: - Page
struct InfoPage: Codable {
    let current, pages: Int?
    let hasNext, hasPrevious: Bool?

    enum CodingKeys: String, CodingKey {
        case current, pages
        case hasNext = "has_next"
        case hasPrevious = "has_previous"
    }
}
