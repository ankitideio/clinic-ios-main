//
//  CateogryModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 26/11/2022.
//

import Foundation
struct Cateogry: Codable {
    let uuid: String?
    let createdDate, name, description, clinic: String?
  
    enum CodingKeys: String, CodingKey {
        case uuid
        case createdDate = "created_date"
        case name, description, clinic
        
    }
}
