//
//  AddWorkingDaysAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 07/03/2023.
//

import Foundation
protocol AddWorkingDaysAPIProtocol {
    func AddWorkingDay(params: [String:Any], completion: @escaping (Result<AddWorkingDayModel?, MyCustomError>) -> Void)
}

class AddWorkingDaysAPI: BaseAPI<AddWorkingDaysNetworking>, AddWorkingDaysAPIProtocol {
 
    func AddWorkingDay(params: [String : Any], completion: @escaping (Result<AddWorkingDayModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .AddWorkingDay(params), responseClass: AddWorkingDayModel.self) { result in
            completion(result)
        }
    }
}

struct AddWorkingDayModel : Codable {
    let success:Bool?
    let message:String?
    let data : workingDayElement?
}

struct workingDayElement : Codable {
    let uuid : String?
    let name : String?
}
