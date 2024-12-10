//
//  DentistryAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
protocol DentistryAPIProtocol {
    func getVisits(patientID:Int,completion: @escaping (Result<[Dentistry]?, MyCustomError>) -> Void)
}


class DentistryAPI: BaseAPI<DentistryNetworking>, DentistryAPIProtocol {
    func getVisits(patientID: Int,completion: @escaping (Result<[Dentistry]?, MyCustomError>) -> Void) {
        self.fetchData(target: .getDentistry(patientIS: "\(patientID)"), responseClass: [Dentistry].self) { result in
            completion(result)
        }
    }
}
