//
//  Constant.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//


import Foundation
import UIKit

let baseURL = "https://lnkrbackend.link/api/"
let imageURL = "https://github.com/lnkr-ai/"
public typealias parameters = [String:Any]
let securityKey = "Lnkr"
var noInternetConnection = "No Internet Connection Available"
var appName = "Lnkr"
var placeId = 0
var textLeft = false
let window = UIApplication.shared.windows.first



//STORE FILE
enum DefaultKeys: String{
    case patientId
    case isSearch
    case patientName
}

//MARK: API - SERVICES
enum Services: String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


//MARK: API - ENUM
enum API: String
{
    
    case persnalInfo = "patient"
    case addPatient = "patient/register_patient/"
    case searchPatinet = "dentist"
}

enum dateFormat: String {
    case fullDate = "EEEE, MMMM dd, yyyy"
    case MonthDayYear = "MMM d, yyyy"
    case MonthDay = "MMM dd EEE"
    case DateAndTime = "dd/M/yyyy hh:mm a"
    case TimeWithAMorPMandMonthDay = "hh:mm a MMM dd EEE"
    case TimeWithAMorPMandDate = "hh:mm a MMM d, yyyy"
    case dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yearMonthFormat = "yyyy-MM-dd"
    case slashDate = "dd/MM/yyyy"
    case timeAmPm = "hh:mm a"
    case BackEndFormat  = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateTime = "hh:mm a "
}

//MARK: REGEX - MESSAGE
enum RegexMessage: String {
    case invalidBlnkEmail = "Please enter email"
  
}


enum constantMessages:String{
    
    case internetError  = "Please check your internet connectivity"
 
    var instance : String {
        return self.rawValue
    }
}
 

