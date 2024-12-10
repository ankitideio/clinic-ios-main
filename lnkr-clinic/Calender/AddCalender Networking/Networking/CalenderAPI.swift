//
//  CalenderAPI.swift
//  lnkr-clinic
//
//  Created by Zaki on 27/11/2022.
//

import Foundation
protocol CalenderAPIProtocol {
    
    
    func addVisit(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String , completion:@escaping (Result<BaseResponse<Calender>?, MyCustomError>) -> Void)
    
    
    func addEvent(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String , completion:@escaping (Result<BaseResponse<Calender>?, MyCustomError>) -> Void)
    
    func getEvents(completion: @escaping (Result<BaseResponse<Events>?, MyCustomError>) -> Void)
    
    func getPatientNames(dentID: String ,completion: @escaping (Result<BaseResponse<[PatientNames]>?, MyCustomError>) -> Void)
    
}


class CalenderAPI: BaseAPI<CalenderNetworking>, CalenderAPIProtocol {
   
    
    
    func getPatientNames(dentID: String,completion: @escaping (Result<BaseResponse<[PatientNames]>?, MyCustomError>) -> Void) {
        self.fetchData(target: .getPatientNames(dentID: dentID), responseClass: BaseResponse<[PatientNames]>.self) { result in
            completion(result)
        }
    }
    
    func getEvents(completion: @escaping (Result<BaseResponse<Events>?, MyCustomError>) -> Void) {
        self.fetchData(target: .getEvents, responseClass: BaseResponse<Events>.self) { result in
            completion(result)
        }
    }
    
    
    func addEvent(patientID: Int, title: String, type: String, visit_status: String, visit_type: String, start: String, end: String, cost: String , completion: @escaping (Result<BaseResponse<Calender>?, MyCustomError>) -> Void) {
        self.fetchData(target: .addEvent(patientID: patientID, title: title, type: type ,visit_status:visit_status,visit_type: visit_type,start: start, end: end ,cost:cost), responseClass: BaseResponse<Calender>.self) { result in
            completion(result)
        }
    }
    
    
    func addVisit(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String, completion: @escaping (Result<BaseResponse<Calender>?, MyCustomError>) -> Void) {
        self.fetchData(target: .addVisit(patientID: patientID, title: title, type: type ,visit_status:visit_status,visit_type: visit_type,start: start, end: end ,cost:cost), responseClass: BaseResponse<Calender>.self) { result in
            completion(result)
        }
    }  
}
