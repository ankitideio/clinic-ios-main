//
//  ClinicAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import Foundation
protocol ClinicAPIProtocol {
    func readClinic(clinicID:String,completion: @escaping (Result<BaseResponse<Cliniccc>?, MyCustomError>) -> Void)
    func updateClinic(clicnicID:String,params:[String:Any],completion: @escaping (Result<BaseResponse<Cliniccc>?, MyCustomError>) -> Void)
}


class ClinicAPI: BaseAPI<ClinicNetworkung>, ClinicAPIProtocol {
   
    func readClinic(clinicID: String, completion: @escaping (Result<BaseResponse<Cliniccc>?, MyCustomError>) -> Void) {
        self.fetchData(target: .readClinic(clinicID: clinicID), responseClass: BaseResponse<Cliniccc>.self) { result in
            completion(result)
        }
    }
    
    func updateClinic(clicnicID: String, params: [String : Any], completion: @escaping (Result<BaseResponse<Cliniccc>?, MyCustomError>) -> Void) {
        self.fetchData(target: .updateClinic(clinicID: clicnicID, params: params), responseClass: BaseResponse<Cliniccc>.self) { result in
            completion(result)
        }
    }
}
