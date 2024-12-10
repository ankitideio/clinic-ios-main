//
//  ScanModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

struct ScanBaseModel:Codable {
    let success: Bool?
    let page: Page?
    let data: [Scan]?
    let message: String?
}
struct Scan: Codable {
    let uuid: String
    let scanResult: String
    let scanName, createdDate: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case scanResult = "scan_result"
        case scanName = "scan_name"
        case createdDate = "created_date"
    }
}
