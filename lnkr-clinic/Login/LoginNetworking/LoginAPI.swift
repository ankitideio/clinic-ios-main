//
//  LoginAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation

protocol LoginAPIProtocol {
    func Login(email:String,password:String,completion: @escaping (Result<BaseResponse<UserInfo>?, MyCustomError>) -> Void)
}

class LoginAPI: BaseAPI<LoginNetworking>, LoginAPIProtocol {
    func Login(email: String, password: String, completion: @escaping (Result<BaseResponse<UserInfo>?, MyCustomError>) -> Void) {
        self.fetchData(target: .login(email: email, password: password), responseClass: BaseResponse<UserInfo>.self) { result in
            completion(result)
        }
    }
}
