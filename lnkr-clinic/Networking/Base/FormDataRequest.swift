//
//  FormDataRequest.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//

import Foundation
import Alamofire
class APIReq {
    
    static let shared = APIReq()
    //MARK: - perform MultiPart Request
    @discardableResult
    func performRequest<T:Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, fileUrlKey: [String], files:[Data], filesNames:[String], mimeTypes:[String], completion: @escaping (_ result:Result<T, AFError>,_ statusCode:Int?)->Void) -> DataRequest {
//        let headers = Alamofire.HTTPHeaders(["":])
        return AF.upload(multipartFormData: { (multipartFormData) in

            for index in 0..<fileUrlKey.count{
                multipartFormData.append(files[index], withName: fileUrlKey[index], fileName: filesNames[index], mimeType: mimeTypes[index])
            }

            
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
 
            
        }, to: url, headers:[.authorization(bearerToken: General.getUserToken())] ).responseDecodable (decoder: JSONDecoder()){ (response: DataResponse<T, AFError>) in

            debugPrint(response)
            completion(response.result, response.response?.statusCode)
        }
    }
}
