//
//  VisitsModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
struct VisitModel: Codable {
    let scheduledDate, visitStatus, visitType, visitCost: String?
    let patientDiscount, lnkrCommission: String?
    let totalCost, clinic: String?

    enum CodingKeys: String, CodingKey {
        case scheduledDate = "scheduled_date"
        case visitStatus = "visit_status"
        case visitType = "visit_type"
        case visitCost = "visit_cost"
        case patientDiscount = "patient_discount"
        case lnkrCommission = "lnkr_commission"
        case totalCost = "total_cost"
        case clinic
    }
}
