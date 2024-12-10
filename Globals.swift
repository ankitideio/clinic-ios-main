//
//  Globals.swift
//  MoltaqaTask
//
//  Created by Zaki on 25/10/2022.
//

import UIKit
let defaults = UserDefaults.standard

enum storyboards: String {
    case Main = "Main"
    case AddPatient = "AddPatient"
    case Login      = "Login"
    case AddDrug    = "AddDrug"
    case ADDPrescription = "ADDPrescription"
    case PrescriptionsClinic = "PrescriptionsClinic"
    case Accounting = "Accounting"
    case Insurence  = "Insurence"
    case Contracts  = "Contracts"
    case PINCode    = "PINCode"
    case PatientDetails = "PatientDetails"
    case Setting    = "Setting"
    case Patients = "Patients"
    case SideMenu = "SideMenu"
    case Home     = "Home"
    case calender = "Calender"
    case Cateogries = "Cateogries"
    case patientOtp = "PatientOtp"
    case patientInfo = "PatientInfo"
    case vitalDetail = "VitalDetail"
}

func currentStoryboard(_ storyboard: storyboards) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: nil)
}

let blueColor = hexStringToUIColor(hex: "0176D3")
let DarkBlueColor = hexStringToUIColor(hex: "032D5f")

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
