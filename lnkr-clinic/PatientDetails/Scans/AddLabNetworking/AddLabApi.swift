//
//  AddScanApi.swift
//  lnkr-clinic
//
//  Created by Zaki on 20/11/2022.
//

import Foundation

protocol AddLabAPIProtocol {
    func AddLab(labResult: String, labName:String ,completion: @escaping (Result<BaseResponse<AddLabInfo>?, NSError>) -> Void)
}

class AddLabAPI: BaseAPI<AddLabNetworking>, AddLabAPIProtocol {
    
    func AddLab(labResult: String, labName: String, completion: @escaping (Result<BaseResponse<AddLabInfo>?, NSError>) -> Void) {
        self.fetchData(target: .AddLab(labResult: labResult, labName: labName), responseClass: BaseResponse<AddLabInfo>.self) { result in
            completion(result)
        }
    }
        
}
       

