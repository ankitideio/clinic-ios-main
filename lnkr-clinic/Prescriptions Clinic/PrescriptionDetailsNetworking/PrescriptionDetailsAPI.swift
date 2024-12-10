//
//  PrescriptionDetailsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//

import Foundation
protocol PrescriptionDetailsAPIProtocol {
    func getPrescriptionDetails(uuid:String,completion: @escaping (Result<Details?, MyCustomError>) -> Void)
}


class PrescriptionDetailAPI: BaseAPI<PrescriptionDetailsNetworking>, PrescriptionDetailsAPIProtocol {
    func getPrescriptionDetails(uuid: String, completion: @escaping (Result<Details?, MyCustomError>) -> Void) {
        self.fetchData(target: .getPrescriptionDtails(uuid: uuid), responseClass: Details.self) { result in
            completion(result)
        }
    }
    
    
}
