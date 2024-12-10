//
//  RequestsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//

import Foundation
protocol RequestsAPIProtocol {
    func getRequests(dentistID:String,completion: @escaping (Result<Requests?, MyCustomError>) -> Void)
    func addRequest(dentistID:String,title:String,body:String,completion: @escaping (Result<AddRequest?, MyCustomError>) -> Void)
}


class RequestsAPI: BaseAPI<RequestsNetworking>, RequestsAPIProtocol {
    
    func getRequests(dentistID: String, completion: @escaping (Result<Requests?, MyCustomError>) -> Void) {
        self.fetchData(target: .getRequests(dentistID: dentistID), responseClass: Requests.self) { result in
            completion(result)
        }
    }
    
    func addRequest(dentistID: String, title: String, body: String, completion: @escaping (Result<AddRequest?, MyCustomError>) -> Void) {
        self.fetchData(target: .addRequest(dentistID: dentistID, title: title, body: body), responseClass: AddRequest.self) { result in
            completion(result)
        }
    }
    
}
