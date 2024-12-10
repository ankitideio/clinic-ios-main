//
//  AccountingAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/12/2022.
//

import Foundation

protocol AccountingAPIProtocol {
    func getAccounting(dentistID:Int,completion: @escaping (Result<Accounting?, MyCustomError>) -> Void)
}

class AccountingAPI: BaseAPI<AccountingNetwqorking>, AccountingAPIProtocol {
    func getAccounting(dentistID: Int, completion: @escaping (Result<Accounting?, MyCustomError>) -> Void) {
        self.fetchData(target: .getAccounting(dentistID: dentistID), responseClass: Accounting.self) { result in
            completion(result)
        }
    }
}
