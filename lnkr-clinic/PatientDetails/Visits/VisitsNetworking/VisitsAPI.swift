//
//  VisitsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
protocol VisitsAPIProtocol {
    func getVisits(userID:Int, page: Int,completion: @escaping (Result<BaseResponse<[VisitModel]>?, MyCustomError>) -> Void)
}


class VisitsAPI: BaseAPI<VisitsNetworking>, VisitsAPIProtocol {
    func getVisits(userID: Int, page: Int ,completion: @escaping (Result<BaseResponse<[VisitModel]>?, MyCustomError>) -> Void) {
        self.fetchData(target: .getVisits(patientIS: "\(userID)", page: page), responseClass: BaseResponse<[VisitModel]>.self) { result in
            completion(result)
        }
    }
}
