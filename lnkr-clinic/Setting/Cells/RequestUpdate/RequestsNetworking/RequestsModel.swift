//
//  RequestsModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//

import Foundation
struct Requests: Codable {
    let success: Bool?
    let data: [RequestsData]?
    let message: String?
}

struct AddRequest: Codable {
    let success: Bool?
    let message: String?
}

// MARK: - RequestsData
struct RequestsData: Codable {
    let uuid, dentist, title, request: String?
    let comments: String?
    let done: Bool?
    let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case uuid, dentist, title, request, comments, done
        case createdDate = "created_date"
    }
}
