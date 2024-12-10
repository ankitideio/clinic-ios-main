//
//  AccountingModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/12/2022.
//

import Foundation

// MARK: - Accounting
struct Accounting: Codable {
    let success: Bool?
    let data: AccountingData?
    let message: String?
}

// MARK: - DataClass
struct AccountingData: Codable {
    let totalPatients, totalVisitsCost, totalLnkrFees, totalIncome: Int?
    let patients: [AccountingPatient]?

    enum CodingKeys: String, CodingKey {
        case totalPatients = "total_patients"
        case totalVisitsCost = "total_visits_cost"
        case totalLnkrFees = "total_lnkr_fees"
        case totalIncome = "total_income"
        case patients
    }
}

struct AccountingPatient: Codable {
    let id: Int?
    let fullName: String?
    let totalData: TotalData?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case totalData = "total_data"
    }
}

// MARK: - TotalData
struct TotalData: Codable {
    let totalVisits, feesPaid, doctorDiscount, lnkrDiscount: Int?
    let totalIncome: Int?

    enum CodingKeys: String, CodingKey {
        case totalVisits = "total_visits"
        case feesPaid = "fees_paid"
        case doctorDiscount = "doctor_discount"
        case lnkrDiscount = "lnkr_discount"
        case totalIncome = "total_income"
    }
}
