//
//  PhysicanAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 02/12/2022.
//

import Foundation
protocol PhysicanAPIProtocol {
    func updateDentist(dentistID:String,details:[String:Any],completion: @escaping (Result<BaseResponse<UserInfo>?, MyCustomError>) -> Void)
    func updatePassword(oldPassword:String , newPassword:String,completion: @escaping (Result<ResetPass? , MyCustomError>) -> Void)
    func getDentistInfo(completion: @escaping (Result<DentistInfo? , MyCustomError>) -> Void)
    func updateDentistPricing(params:[String:Any],completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void)
}


class PhysicanAPI: BaseAPI<PhysicanNetworking>, PhysicanAPIProtocol {
    
    func updateDentistPricing(params: [String : Any], completion: @escaping (Result<GeneralModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .updateDentistPricing(params), responseClass: GeneralModel.self) { result in
            completion(result)
        }
    }
    
    
    func getDentistInfo(completion: @escaping (Result<DentistInfo?, MyCustomError>) -> Void) {
        self.fetchData(target: .getDentistInfo, responseClass: DentistInfo.self) { result in
            completion(result)
        }
    }
    
   
    func updateDentist(dentistID: String, details: [String : Any], completion: @escaping (Result<BaseResponse<UserInfo>?, MyCustomError>) -> Void) {
        self.fetchData(target: .updateDentist(dentstID: dentistID, dentistDetails: details), responseClass: BaseResponse<UserInfo>.self) { result in
            completion(result)
        }
    }
    
    func updatePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<ResetPass?, MyCustomError>) -> Void) {
        self.fetchData(target: .updatePassword(oldPassord: oldPassword, newPassword: newPassword), responseClass: ResetPass.self) { result in
            completion(result)
        }
    }
}

struct GeneralModel:Codable {
    let success:Bool?
    let message:String?
}
