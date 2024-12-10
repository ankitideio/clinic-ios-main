//
//  LoginDataSource.swift
//  LnkrClinic
//
//  Created by Zaki on 05/11/2022.
//

import Foundation
import Alamofire
//import SwiftyJSON

class LoginDataSource {
    
    
    func login(email : String , password : String , isSucess : @escaping(LoginModelResponse?) -> Void , isError : @escaping (String) -> Void ){
        
        //let loginRequest = AuthenticationRouter.login(email: email, password: String )
        
        var url = "https://lnkrdev.herokuapp.com/api/token/"
        let para : [String : Any] = ["email": email,
                                     "password": password]
        
//        let param : [[String : Any]] = [["email": email,
//                                         "password": password] , ["email": email,
//                                                                  "password": password]]
        
        AF.request(url, method: .post, parameters: para, encoding: JSONEncoding.default).responseDecodable { (response: DataResponse<LoginModelResponse, AFError>) in
            switch response.result {
            case let .success(data):
                isSucess(data)
                
            case let .failure(error):
                print(error.localizedDescription)
                isError("UnknownError")
            }
        }
    }
}
