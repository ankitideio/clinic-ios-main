//
//  SyndicateAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/03/2023.
//

import Foundation
protocol SyndicateAPIProtocol {
    func addSyndicateInfo(params:[String:String],completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void)
}


class SyndicateAPI: BaseAPI<SyndicateNetworking>, SyndicateAPIProtocol {
    func addSyndicateInfo(params: [String : String], completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .addSyndicateInfo(params: params), responseClass: GeneralModel.self) { result in
            completion(result)
        }
    }
}
