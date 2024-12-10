//
//  AssistantAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import Foundation
protocol AccountInfoAPIProtocol {
    func updateAccountInfo(params:[String:Any],completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void)
}


class AccountInfoAPI: BaseAPI<AccountInfoNetworking>, AccountInfoAPIProtocol {
    func updateAccountInfo(params: [String : Any], completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .updateAccountInf(params: params), responseClass: GeneralModel.self) { result in
            completion(result)
        }
    }
}
