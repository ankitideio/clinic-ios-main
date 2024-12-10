//
//  CateogriesAPI.swift
//  lnkr-clinic
//
//  Created by Zaki on 26/11/2022.
//


import Foundation
protocol CateogriesAPIProtocol {
    func getCateogriess(clinicID : String , completion: @escaping (Result<BaseResponse<[Cateogry]>?, MyCustomError>) -> Void)
    
    func addCateogry(clinicID : String ,name:String, completion:@escaping (Result<BaseResponse<Cateogry>?, MyCustomError>) -> Void)
    
    
    func deleteCateogry(clinicID : String, cateogrID : String, completion: @escaping (Result<BaseResponse<Cateogry>?, MyCustomError>) -> Void)
}


class CateogriesAPI: BaseAPI<CateogriesNetworking>, CateogriesAPIProtocol {
    
    
    func addCateogry(clinicID: String ,name: String, completion: @escaping (Result<BaseResponse<Cateogry>?, MyCustomError>) -> Void) {
        self.fetchData(target: .addCateogry(clinicID: clinicID, name: name), responseClass: BaseResponse<Cateogry>.self) { result in
            completion(result)
        }
    }
    
    
    
    func getCateogriess(clinicID: String ,completion: @escaping (Result<BaseResponse<[Cateogry]>?, MyCustomError>) -> Void) {
        
        self.fetchData(target: .getCateogries(clinicID: clinicID) , responseClass: BaseResponse<[Cateogry]>.self) { result in
            completion(result)
        }
    }
    
    func deleteCateogry(clinicID: String,cateogrID : String ,completion: @escaping (Result<BaseResponse<Cateogry>?, MyCustomError>) -> Void) {
        
        self.fetchData(target: .deleteCateogry(clinicID: clinicID , cateogryID: cateogrID) , responseClass: BaseResponse<Cateogry>.self) { result in
            completion(result)
        }
    }
}
