//
//  ReportModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

struct ReportBaseModel:Codable {
    let success: Bool?
    let page: Page?
    let data: [Report]?
    let message: String?
}

struct Report: Codable {
    let uuid, title, body, createdDate: String
    let reportResult: String?

    enum CodingKeys: String, CodingKey {
        case uuid, title, body
        case createdDate = "created_date"
        case reportResult = "report_result"
    }
}
