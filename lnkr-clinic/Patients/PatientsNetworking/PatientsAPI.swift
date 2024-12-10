//
//  PatientsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation

protocol PatientsAPIProtocol {
    func getPatients(userID:Int,page:Int,completion: @escaping (Result<PatientBaseModel?, MyCustomError>) -> Void)
}


class PatientsAPI: BaseAPI<PatientNetworking>, PatientsAPIProtocol {
    func getPatients(userID: Int, page: Int, completion: @escaping (Result<PatientBaseModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .getPatients(dentistID: "\(userID)", page: page), responseClass: PatientBaseModel.self) { result in
            completion(result)
        }
    }
}
