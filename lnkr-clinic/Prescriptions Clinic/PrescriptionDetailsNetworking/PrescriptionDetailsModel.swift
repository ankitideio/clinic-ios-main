//
//  PrescriptionDetailsModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//

import Foundation
struct Details: Codable {
    let success: Bool?
    let data: DataClass?
    let message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let drug: [DrugModel]?
    let uuid: String?
    let notes: Notes?
    let createdDate: String?
    let diseases: [Disease]?
    let patient: PresPatient?
    let dentist: Dentist?
    let clinic: Clinic?
    let insurance: String?

    enum CodingKeys: String, CodingKey {
        case drug, uuid, notes
        case createdDate = "created_date"
        case diseases, patient, dentist, clinic, insurance
    }
}

// MARK: - Clinic
struct Clinic: Codable {
    let uuid, name, phoneNum, registrationID: String?
    let joinedDate: String?
    let workingDaysHours: [WorkingDaysHour]?
    let address: Address?
    let specialities: [Speciality]?
    let room: [String]?
    let event: [Event]?

    enum CodingKeys: String, CodingKey {
        case uuid, name
        case phoneNum = "phone_num"
        case registrationID = "registration_id"
        case joinedDate = "joined_date"
        case workingDaysHours = "working_days_hours"
        case address, specialities, room, event
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let long, lat: Double?
    let city, zipCode, street, building: String?
    let floor: Int?

    enum CodingKeys: String, CodingKey {
        case id, long, lat, city
        case zipCode = "zip_code"
        case street, building, floor
    }
}

// MARK: - Event
struct Event: Codable {
    let title: String?
    let location: String?
    let allDay: Bool?
    let type: String?
    let start, end: String?

    enum CodingKeys: String, CodingKey {
        case title, location
        case allDay = "all_day"
        case type, start, end
    }
}


// MARK: - Speciality
struct Speciality: Codable {
    let id: Int?
    let specialities: String?
}

// MARK: - WorkingDaysHour
struct WorkingDaysHour: Codable {
    let id: String?
    let day: String?
    let hours: [String]?
}

// MARK: - Disease
struct Disease: Codable {
    let label: String?
    let value: Int?
}

struct Employee: Codable {
    let uuid:String?
    let full_name:String?
}

// MARK: - Drug
struct DrugModel: Codable {
    let dose, comment, drugID, frequency: String?
    let generalName, dosageFormat, foodPlacement, forHowLongIndex: String?
    let forHowLongDuration: String?

    enum CodingKeys: String, CodingKey {
        case dose, comment
        case drugID = "drug_id"
        case frequency
        case generalName = "general_name"
        case dosageFormat = "dosage_format"
        case foodPlacement = "food_placement"
        case forHowLongIndex = "for_how_long_index"
        case forHowLongDuration = "for_how_long_duration"
    }
}

// MARK: - Notes
struct Notes: Codable {
    let labs, scans, medicalSupplies: String?

    enum CodingKeys: String, CodingKey {
        case labs, scans
        case medicalSupplies = "medical_supplies"
    }
}

// MARK: - Patient
struct PresPatient: Codable {
    let id: Int?
    let fullName, birthdate, gender: String?
    let emergencyContact: String?
    let profession, company: String?
    let hasCard: Bool?
    let cardNumber: String?
    let pinCode: String?
    let address, homeAddress, workAddress: String?
    let profile: Profile?
    let profilePic, bloodType, drugAllergy: String?
    let employee: Employee?
    let foodAllergy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case birthdate, gender
        case emergencyContact = "emergency_contact"
        case profession, company
        case hasCard = "has_card"
        case cardNumber = "card_number"
        case pinCode = "pin_code"
        case address
        case homeAddress = "home_address"
        case workAddress = "work_address"
        case profile
        case profilePic = "profile_pic"
        case employee
        case bloodType = "blood_type"
        case drugAllergy = "drug_allergy"
        case foodAllergy = "food_allergy"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let uuid: String?
    let dentist, assistant, employee, pharmacist: String?
    let labEmployee, scanEmployee: String?
    let patientID: Int?
    let email, mobile, nationalID: String?
    let activated: Bool?
    let dateJoined, lastLogin: String?
    let isAdmin, isActive, isStaff, isSuperuser: Bool?
    let groups, userPermissions: [String]?

    enum CodingKeys: String, CodingKey {
        case uuid, dentist, assistant, employee, pharmacist
        case labEmployee = "lab_employee"
        case scanEmployee = "scan_employee"
        case patientID = "patient_id"
        case email, mobile
        case nationalID = "national_id"
        case activated
        case dateJoined = "date_joined"
        case lastLogin = "last_login"
        case isAdmin = "is_admin"
        case isActive = "is_active"
        case isStaff = "is_staff"
        case isSuperuser = "is_superuser"
        case groups
        case userPermissions = "user_permissions"
    }
}
