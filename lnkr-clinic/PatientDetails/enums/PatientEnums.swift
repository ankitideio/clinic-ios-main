//
//  PatientEnums.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import Foundation
enum treatmentCase:CaseIterable {
    case dentistry
    case pediatrics
    case ent
    case orthopedics
    case ophthalmology
    case gynecology
    case generalsergery
}

enum patientCase:CaseIterable {
    case personalInfo
    case treatment
    case visit
    case prescriptions
    case labs
    case scans
    case reports
}
