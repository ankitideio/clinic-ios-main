//
//  EventsModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 02/12/2022.
//

import Foundation

struct GetEvents : Codable{
    let data : Events
}
struct Events: Codable{
    let events : [EventsData]?
}
struct EventsData: Codable{
    let title: String?
    let location: String?
    let all_day: Bool?
    let type: String?
    let start: String?
    let end: String?
}

