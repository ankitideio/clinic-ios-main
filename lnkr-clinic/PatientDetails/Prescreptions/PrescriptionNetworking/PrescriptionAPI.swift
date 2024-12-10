//
//  PrescriptionAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 19/11/2022.
//

import Foundation
protocol PrescriptionAPIProtocol {
    func getPrescription(patientID:Int, page: Int,completion: @escaping (Result<prescriptionBaseModel?, MyCustomError>) -> Void)
    func getInsurenves(completion: @escaping (Result<[Insurence]? , MyCustomError>) -> Void)
    func getDesease(completion: @escaping (Result<[Insurence]? , MyCustomError>) -> Void)
    func addPrescriptionaddPrescription(prescription:[String:Any],completion: @escaping (Result<AddingPresCription? , MyCustomError>) -> Void)
}

class PrescriptionAPI: BaseAPI<PrescriptionNetworking>, PrescriptionAPIProtocol {
    func addPrescriptionaddPrescription(prescription:[String:Any],completion: @escaping (Result<AddingPresCription?, MyCustomError>) -> Void) {
        self.fetchData(target: .addPrescription(prescription: prescription), responseClass: AddingPresCription.self) { result in
            completion(result)
        }
    
    }
    
    func getDesease(completion: @escaping (Result<[Insurence]?, MyCustomError>) -> Void) {
        self.fetchData(target: .getDesease, responseClass: [Insurence].self) { result in
            completion(result)
        }
    }
    
    func getInsurenves(completion: @escaping (Result<[Insurence]?, MyCustomError>) -> Void) {
        self.fetchData(target: .getInsurences, responseClass: [Insurence].self) { result in
            completion(result)
        }
    }
    
    func getPrescription(patientID: Int, page: Int ,completion: @escaping (Result<prescriptionBaseModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .getPrescriptions(patientID: "\(patientID)", page: page), responseClass: prescriptionBaseModel.self) { result in
            completion(result)
        }
    }
}
