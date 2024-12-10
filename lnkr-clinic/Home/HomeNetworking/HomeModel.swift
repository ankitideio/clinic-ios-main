//
//  HomeModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation

struct HomeModel : Codable {
    let patients:Int?
    let prescriptions:Int?
    let visits:[Visit]?
}

struct Visit: Codable {
    let title: String
    let patientID: Int
    let type, visitStatus, visitType, start: String
    let end: String

    enum CodingKeys: String, CodingKey {
        case title
        case patientID   = "patient_id"
        case type
        case visitStatus = "visit_status"
        case visitType   = "visit_type"
        case start, end
    }
}
