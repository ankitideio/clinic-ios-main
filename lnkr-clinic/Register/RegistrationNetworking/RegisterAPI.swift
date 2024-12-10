//
//  RegisterAPI.swift
//  lnkr-patient
//
//  Created by MohamedNajeh on 22/01/2023.
//

import Foundation
protocol RegisterAPIProtocol {
    func register(params:[String:Any],completion: @escaping (Result<PatientResponse?, MyCustomError>) -> Void)
    func getCitites(completion: @escaping (Result<Cities?, MyCustomError>) -> Void)
}

class RegisterAPI: BaseAPI<RegisterNetworking>, RegisterAPIProtocol {
    func getCitites(completion: @escaping (Result<Cities?, MyCustomError>) -> Void) {
        self.fetchData(target: .getCities, responseClass: Cities.self) { result in
            completion(result)
        }
    }
    
    func register(params:[String:Any], completion: @escaping (Result<PatientResponse?, MyCustomError>) -> Void) {
        self.fetchData(target: .register(params), responseClass: PatientResponse.self) { result in
            completion(result)
        }
    }
}
