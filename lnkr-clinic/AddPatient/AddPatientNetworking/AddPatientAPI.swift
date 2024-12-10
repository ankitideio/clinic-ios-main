//
//  AddPatientAPI.swift
//  lnkr-clinic
//
//  Created by Zaki on 19/11/2022.
//

import Foundation

protocol AddPatientAPIProtocol {
    func AddPatient(fullName: String, birthdate:String , mobile: String , nationalID: String , gender: Int , pinCode: String , bloodType: String , drugAllergy: String , foodAllergy: String,completion: @escaping (Result<BaseResponse<AddPatientUserInfo>?, MyCustomError>) -> Void)
}

class AddPatientAPI: BaseAPI<AddPatientNetworking>, AddPatientAPIProtocol {
    func AddPatient(fullName: String, birthdate:String , mobile: String , nationalID: String , gender: Int , pinCode: String , bloodType: String , drugAllergy: String , foodAllergy: String, completion: @escaping (Result<BaseResponse<AddPatientUserInfo>?, MyCustomError>) -> Void) {
        self.fetchData(target: .AddPatient(fullName: fullName, birthdate:birthdate , mobile: mobile , nationalID: nationalID , gender: gender , pinCode: pinCode , bloodType: bloodType , drugAllergy: drugAllergy , foodAllergy: foodAllergy), responseClass: BaseResponse<AddPatientUserInfo>.self) { result in
            completion(result)
        }
    }
}
