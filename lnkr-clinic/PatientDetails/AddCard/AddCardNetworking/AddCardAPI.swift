//
//  AddCardAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 26/12/2022.
//

import Foundation
protocol AddCardAPIProtocol {
    func addCard(dentistID:String,patientID:String,cardNumber:String , pinCode:String ,completion: @escaping (Result<PINCode?, MyCustomError>) -> Void)
}

class AddCardAPI: BaseAPI<AddCardNetworking>, AddCardAPIProtocol {
    func addCard(dentistID: String, patientID: String, cardNumber: String, pinCode: String, completion: @escaping (Result<PINCode?, MyCustomError>) -> Void) {
        self.fetchData(target: .addCard(dentistID: dentistID, patientID: patientID, cardNumber: cardNumber, pinCode: pinCode), responseClass: PINCode.self) { result in
            completion(result)
        }
    }
}
