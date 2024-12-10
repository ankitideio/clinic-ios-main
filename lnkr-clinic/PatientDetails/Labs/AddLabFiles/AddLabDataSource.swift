//
//  AddLabDataSource.swift
//  lnkr-clinic
//
//  Created by Zaki on 23/11/2022.
//

import Foundation
import Alamofire

protocol NetworkDelegate {
    
    func updateProgressViewWith(fractions:Double)
}

class AddLabDataSource {
    static var delegate:NetworkDelegate?
    func AddLab(File fileData: Data ,url:String,patientID:String ,WithName fileName:String , labName : String,quryItem:String , isSucess : @escaping(AddLabModelResponse?) -> Void , isError : @escaping (String) -> Void ){
        
        var urlComps = URLComponents(string: url)!
        let queryItems = [URLQueryItem(name: quryItem, value: labName)]
        urlComps.queryItems = queryItems
        // print(urlComps.queryItems)
        let headers:HTTPHeaders = ["Authorization": "Bearer \(General.getUserToken())","Content-Type":"multipart/form-data","Accept":"application/json"]
        //let method:HTTPMethod = .post
        let result = urlComps.url!
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(fileData, withName: fileName, fileName: "\(fileName).png", mimeType: "image/png")
            multipartFormData.append(labName.data(using: .utf8) ?? Data(), withName: quryItem)
            
        }, to: result,method: .post, headers: headers).uploadProgress(closure: { (progress) in
            
            AddLabDataSource.delegate?.updateProgressViewWith(fractions: progress.fractionCompleted)
            
        }) .responseDecodable { (response: DataResponse<AddLabModelResponse, AFError>) in
            
            switch response.result {
                
            case .failure(let error):
                
                print(error.localizedDescription)
                isError(error.localizedDescription)
                break
                
            case .success(let model):
                
                print(response.response!.statusCode)
                
                print(model.message ?? "")
                
                if model.success == true {
                    
                    print("-----------------")
                    
                    print(model.message ?? "Success")
                    
                    print("-----------------")
                    
                    isSucess(model)
                    
                } else {
                    
                    print("Error loading attachment")
                    
                }
                
            }
        }
    }    
}

