//
//  DentistryModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

struct Dentistry: Codable {
    let uuid, actions: String?
    let totalCost, totalPaid: Int?
    let paid:Double?
    let comment: String?
    let createdDate: String?
    let patient, dentist: Int?
    let clinic: String?

    enum CodingKeys: String, CodingKey {
        case uuid, actions
        case totalCost = "total_cost"
        case paid
        case totalPaid = "total_paid"
        case comment
        case createdDate = "created_date"
        case patient, dentist, clinic
    }
}
