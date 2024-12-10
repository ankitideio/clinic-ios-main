//
//  Constants.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
struct ErrorMessage {
    static let genericError       = "Something went wrong please try again later"
    static let serialisationError = "Failed serilize data"
    static let decodeingError     = "can't decode the data"
}

enum URLs:String {
    case baseURL = "https://lnkrbackend.link"
    case devURL  = "https://lnkrdev.link"
}
