//
//  PersonalInfoAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
protocol PersonalInfoAPIProtocol {
    func getPatientInfo(patientID:Int,completion: @escaping (Result<BaseResponse<PersonalInfo>?, MyCustomError>) -> Void)
    func updatePatient(patientID:String,patientDetils:[String:String],completion: @escaping (Result<PersonaLInfoBase?, MyCustomError>) -> Void)
}


class PersonalInfoAPI: BaseAPI<PersonalInfoNetworking>, PersonalInfoAPIProtocol {
    func updatePatient(patientID: String, patientDetils: [String : String], completion: @escaping (Result<PersonaLInfoBase?, MyCustomError>) -> Void) {
        self.fetchData(target: .updatePatient(patientID:patientID,patientDetils:patientDetils), responseClass: PersonaLInfoBase.self) { result in
            completion(result)
        }
    }
    

    
    
    func getPatientInfo(patientID: Int, completion: @escaping (Result<BaseResponse<PersonalInfo>?, MyCustomError>) -> Void) {
        self.fetchData(target: .getPatientOnfo(patientID: patientID), responseClass: BaseResponse<PersonalInfo>.self) { result in
            completion(result)
        }
    }
}
