//
//  CustomInterceptor.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 21/11/2022.
//

import Foundation
import Alamofire

class CustomInterceptor: RequestInterceptor {
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        //, request.request?.url?.absoluteString.contains("home") ?? false
        if let stausCode = request.response?.statusCode
            , stausCode == 401  , request.request?.url?.absoluteString.contains("home") ?? false{
            print("retryyyyyy")
            refreshToken { isRefreshed in
                switch isRefreshed {
                case true:
                    completion(.retry)
                case false:
                    General.openLoginVC()
                    completion(.doNotRetry)
                }
            }
            completion(.retry)
        }else{
           // General.openLoginVC()
            completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        let params = ["refresh":"\(General.getUserRefresh())"]
        AF.request(URLs.baseURL.rawValue + "/api/token/refresh/", method: .post,parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                do{
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(refresh.self, from: data)
                    // guard let cont = resp.data else{return}
                    General.setUserToken(name: resp.access)
                    print(resp.access ?? "")
                    print("refreshed")
                    completion(true)
                }catch{
                    print(error)
                    completion(false)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}

struct refresh: Codable {
    let access:String?
}
