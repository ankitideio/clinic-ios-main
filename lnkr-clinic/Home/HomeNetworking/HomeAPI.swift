//
//  HomeAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation

protocol HomeAPIProtocol {
    func getHome(userID:Int,completion: @escaping (Result<BaseResponse<HomeModel>?, MyCustomError>) -> Void)
}


class HomeAPI: BaseAPI<HomeNetworking>, HomeAPIProtocol {
    func getHome(userID:Int,completion: @escaping (Result<BaseResponse<HomeModel>?, MyCustomError>) -> Void) {
        self.fetchData(target: .getHome(dentistID: "\(userID)"), responseClass: BaseResponse<HomeModel>.self) { result in
            completion(result)
        }
    }
}
