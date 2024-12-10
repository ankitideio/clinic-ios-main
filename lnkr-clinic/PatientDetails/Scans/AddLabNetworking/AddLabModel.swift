//
//  AddScanModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 20/11/2022.
//

import Foundation
struct AddLabInfo : Codable{
    let data : LabInfo?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
    }
}

struct LabInfo : Codable {
    
}
