//
//  LabsModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

struct LabeBaseModel:Codable {
    let success: Bool?
    let page: Page?
    let data: [Lab]?
    let message: String?
}

struct Lab: Codable {
    let uuid: String?
    let labResult: String?
    let labName, createdDate: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case labResult = "lab_result"
        case labName = "lab_name"
        case createdDate = "created_date"
    }
}
