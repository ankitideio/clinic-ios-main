//
//  PINCodeAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/12/2022.
//

import Foundation
protocol PINCodeAPIProtocol {
    func findPatient(cardNumber:String , pinCode:String ,completion: @escaping (Result<PINCode?, MyCustomError>) -> Void)
}

class PINCodeAPI: BaseAPI<PINCodeNetworking>, PINCodeAPIProtocol {
    func findPatient(cardNumber: String, pinCode: String, completion: @escaping (Result<PINCode?, MyCustomError>) -> Void) {
        self.fetchData(target: .findPatient(cardNumber: cardNumber, pinCode: pinCode), responseClass: PINCode.self) { result in
            completion(result)
        }
    }
}
