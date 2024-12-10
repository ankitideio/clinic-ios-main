//
//  VitalDetailModel.swift
//  lnkr-clinic
//
//  Created by meet sharma on 29/04/23.
//

import Foundation

// MARK: - Welcome
struct VitalDetailModel: Codable {
    let success: Bool?
    let data: VitalDetailData?
    let message: String?
}

// MARK: - VitalDetailData
struct VitalDetailData: Codable {
    let uuid, createdDate, weight, height: String?
    let bmi: Double?
    let bloodPressure, sugarLevel, temperature, oxygenSaturation: String?
    let race, pulse: String?

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
    }
}
