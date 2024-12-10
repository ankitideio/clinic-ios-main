//
//  AddPrescriptionsAPI.swift
//  lnkr-clinic
//
//  Created by Zaki on 20/11/2022.
//

import Foundation

protocol AddPrescriptionsAPIProtocol {
    func AddPrescriptions(completion: @escaping (Result<BaseResponse<AddPrescriptionsInfo>?, NSError>) -> Void)
}

class AddPrescriptionsAPI: BaseAPI<AddPrescriptionsNetworking>, AddPrescriptionsAPIProtocol {
    func AddPrescriptions(completion: @escaping (Result<BaseResponse<AddPrescriptionsInfo>?, NSError>) -> Void) {
        self.fetchData(target: .AddPrescriptions, responseClass: BaseResponse<AddPrescriptionsInfo>.self) { result in
            completion(result)
        }
    }
}
