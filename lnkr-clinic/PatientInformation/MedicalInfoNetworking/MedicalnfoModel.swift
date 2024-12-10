//
//  MedicalnfoModel.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//

import Foundation

// MARK: - MedicalInfoModel
struct MedicalInfoModel: Codable {
    let success: Bool?
    let data: MedicalInfoData?
    let message: String?
}

// MARK: - MedicalInfoData
struct MedicalInfoData: Codable {
    let id: Int?
    let fullName, maritalStatus: String?
    let smoking, alcohol, diabetes: Bool?
    let bloodType, drugAllergy, foodAllergy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case maritalStatus = "marital_status"
        case smoking, alcohol, diabetes
        case bloodType = "blood_type"
        case drugAllergy = "drug_allergy"
        case foodAllergy = "food_allergy"
    }
}
