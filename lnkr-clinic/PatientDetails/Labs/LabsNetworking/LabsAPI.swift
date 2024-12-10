//
//  LabsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
protocol LabsAPIProtocol {
    func getLabs(patientID:Int, page: Int,completion: @escaping (Result<LabeBaseModel?, MyCustomError>) -> Void)
}


class LabsAPI: BaseAPI<LabsNetworking>, LabsAPIProtocol {
    func getLabs(patientID: Int, page: Int ,completion: @escaping (Result<LabeBaseModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .getLabs(patientID: "\(patientID)", page: page), responseClass: LabeBaseModel.self) { result in
            completion(result)
        }
    }
}
