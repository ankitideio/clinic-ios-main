//
//  ScansAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
protocol ScansAPIProtocol {
    func getScnas(patientID:Int, page: Int,completion: @escaping (Result<ScanBaseModel?, MyCustomError>) -> Void)
}


class ScansAPI: BaseAPI<ScansNetworking>, ScansAPIProtocol {
    func getScnas(patientID: Int, page: Int ,completion: @escaping (Result<ScanBaseModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .getScans(patientID: "\(patientID)", page: page), responseClass: ScanBaseModel.self) { result in
            completion(result)
        }
    }
}
