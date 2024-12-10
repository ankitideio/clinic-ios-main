//
//  AddClinicAddressAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/03/2023.
//

import Foundation
protocol AddClinicAddressAPIProtocol {
    func addClinicAddress(params:[String:Any],completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void)
}

class AddClinicAddressAPI: BaseAPI<AddClinicAddressNetworking>, AddClinicAddressAPIProtocol {
    func addClinicAddress(params: [String : Any], completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .addAddress(params: params), responseClass: GeneralModel.self) { result in
            completion(result)
        }
    }
}
