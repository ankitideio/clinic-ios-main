//
//  BaseAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation
import Alamofire

struct MyCustomError: Error, Codable {
    let success: Bool?
    let message: String?
}

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Codable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, (MyCustomError)>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method,parameters: params.0, encoding: params.1, headers: headers,interceptor: CustomInterceptor()).validate().responseJSON { (response) in
            print(" ------\( target.baseURL + target.path)")
            print("respone is \(response.value) \(response.response?.statusCode)")
            switch response.result {
            case .success(_):
                print("Responce ",response.value as Any)
                guard let data = response.data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(M.self, from: data)
                    completion(.success(jsonData))
                    
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print(error)
                guard let data = response.data else { return }
                guard let statusCode = response.response?.statusCode else { return }
                print("Status code ->",response.response?.statusCode ?? 0)
                switch statusCode {
                case 400..<500:
                    do {
                        let jsonError = try JSONDecoder().decode(MyCustomError.self, from: data)
                        //let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: jsonError])
                        completion(.failure(jsonError))
                        
                    } catch let jsonError {
                        print(jsonError)
                        let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: jsonError])
                        completion(.failure(MyCustomError(success: false, message: "\(error)")))
                    }
                default:
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed"])
                    completion(.failure(MyCustomError(success: false, message: "\(error)")))
                }
            }
        }
    }
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding())
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
