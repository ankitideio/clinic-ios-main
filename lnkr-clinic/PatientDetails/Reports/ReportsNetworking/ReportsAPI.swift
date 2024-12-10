//
//  ReportsAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
protocol ReportsAPIProtocol {
    func getReports(patientID:Int, page: Int,completion: @escaping (Result<ReportBaseModel?, MyCustomError>) -> Void)
    func addReport(patientID:String , title:String, body:String, completion:@escaping (Result<BaseResponse<Report>?, MyCustomError>) -> Void)
}


class ReportsAPI: BaseAPI<ReportsNetworking>, ReportsAPIProtocol {
    func addReport(patientID: String, title: String, body: String, completion: @escaping (Result<BaseResponse<Report>?, MyCustomError>) -> Void) {
        self.fetchData(target: .addReport(patientID: patientID, title: title, body: body), responseClass: BaseResponse<Report>.self) { result in
            completion(result)
        }
    }
    
    func getReports(patientID: Int, page: Int ,completion: @escaping (Result<ReportBaseModel?, MyCustomError>) -> Void) {
        self.fetchData(target: .getReports(patientID: "\(patientID)", page: page), responseClass: ReportBaseModel.self) { result in
            completion(result)
        }
    }
}
