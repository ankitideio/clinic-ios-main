//
//  AddingPrescripModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/11/2022.
//

import Foundation

// MARK: - AddingPresCription
struct AddingPresCription: Codable {
    let success: Bool?
    let data: AddData?
    let message: String?
}

// MARK: - DataClass
struct AddData: Codable {
    let drug: [Drug]
    let uuid: String
    let notes: Notes
    let createdDate: String
    let diseases: [Disease]
    let patient: AddingPatient
    let dentist: Dentist
    let clinic: Cliniccc?
    let insurance: String?

    enum CodingKeys: String, CodingKey {
        case drug, uuid, notes
        case createdDate = "created_date"
        case diseases, patient, dentist, clinic, insurance
    }
}

enum Location: String, Codable {
    case dummyLocation = "Dummy Location"
}

enum TypeEnum: String, Codable {
    case event = "event"
}

// MARK: - Clinic
struct Cliniccc: Codable {
    let uuid, name, phoneNum, registrationID: String?
    let joinedDate: String
    let address: Addresssss?
    let specialities: [Specialityy]?
    let room: [String]?
    let event: [Eventt]?

    enum CodingKeys: String, CodingKey {
        case uuid, name
        case phoneNum = "phone_num"
        case registrationID = "registration_id"
        case joinedDate = "joined_date"
        case address, specialities, room, event
    }
}

// MARK: - Address
struct Addresssss: Codable {
    let id: Int
    let long, lat: String?
    let city, zipCode, street, building: String
    let floor: Int

    enum CodingKeys: String, CodingKey {
        case id, long, lat, city
        case zipCode = "zip_code"
        case street, building, floor
    }
}

// MARK: - Event
struct Eventt: Codable {
    let title: String?
    let location: Location?
    let allDay: Bool?
    let type: TypeEnum?
    let start, end: String?

    enum CodingKeys: String, CodingKey {
        case title, location
        case allDay = "all_day"
        case type, start, end
    }
}

// MARK: - Speciality
struct Specialityy: Codable {
    let id: Int?
    let specialities: String?
}

// MARK: - WorkingDaysHour
struct WorkingDaysHourr: Codable {
    let id: String?
    let day: String?
    let hours: [String]?
}

// MARK: - Dentist
struct Dentistt: Codable {
    let id: Int
    let fullName, arabicName, syndicateID, qualifications: String
    let arabicQualifications, profile: String
    let clinic: [String]
    let pricing: Pricingg
    let patientDiscount, lnkrCommission: String
    let specialities: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case arabicName = "arabic_name"
        case syndicateID = "syndicate_id"
        case qualifications
        case arabicQualifications = "arabic_qualifications"
        case profile, clinic, pricing
        case patientDiscount = "patient_discount"
        case lnkrCommission = "lnkr_commission"
        case specialities
    }
}

// MARK: - Pricing
struct Pricingg: Codable {
    let others, fastVisit, firstVisit, consultation: Int
    let repeatVisit: Int

    enum CodingKeys: String, CodingKey {
        case others
        case fastVisit = "fast_visit"
        case firstVisit = "first_visit"
        case consultation
        case repeatVisit = "repeat_visit"
    }
}

// MARK: - Disease
struct Diseasee: Codable {
    let label: String
    let value: Int
}

// MARK: - Drug
struct Drugg: Codable {
    let drugID, generalName, dose, frequency: String
    let comment, dosageFormat, forHowLongIndex, forHowLongDuration: String
    let foodPlacement: String

    enum CodingKeys: String, CodingKey {
        case drugID = "drug_id"
        case generalName = "general_name"
        case dose, frequency, comment
        case dosageFormat = "dosage_format"
        case forHowLongIndex = "for_how_long_index"
        case forHowLongDuration = "for_how_long_duration"
        case foodPlacement = "food_placement"
    }
}

// MARK: - Notes
struct Notess: Codable {
    let labs, scans, medicalSupplies: String

    enum CodingKeys: String, CodingKey {
        case labs, scans
        case medicalSupplies = "medical_supplies"
    }
}

// MARK: - Patient
struct AddingPatient: Codable {
    let id: Int?
    let fullName, birthdate, gender: String?
    let emergencyContact: String?
    let profession, company: String?
    let hasCard: Bool?
    let cardNumber: String?
    let pinCode: String?
    let address, homeAddress, workAddress: String?
    let profile: Profileee?
    let profilePic, employee, bloodType, drugAllergy: String?
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
struct Profileee: Codable {
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
