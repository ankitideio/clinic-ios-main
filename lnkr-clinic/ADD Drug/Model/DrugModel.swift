//
//  DrugModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//

import Foundation

struct Drug: Codable {
    let drugID, generalName, dose, frequency: String?
    let comment, dosageFormat, forHowLongIndex, forHowLongDuration: String?
    let foodPlacement: String?

    enum CodingKeys: String, CodingKey {
        case drugID = "drug_id"
        case generalName = "general_name"
        case dose, frequency, comment
        case dosageFormat = "dosage_format"
        case forHowLongIndex = "for_how_long_index"
        case forHowLongDuration = "for_how_long_duration"
        case foodPlacement = "food_placement"
    }
}
