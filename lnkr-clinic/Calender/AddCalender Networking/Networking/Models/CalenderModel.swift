//
//  CalenderModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 27/11/2022.
//

import Foundation
struct Calender: Codable {
    let title: String?
    let type, visit_status,visit_type, start , end: String?
    let patient_id : Int?
}
