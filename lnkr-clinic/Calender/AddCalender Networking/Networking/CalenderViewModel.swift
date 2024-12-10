//
//  CalenderViewModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 28/11/2022.
//

import Foundation
import UIKit

protocol CalenderViewModelProtocol {
    func AddVisit(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String)
    func AddEvent(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String)
    func getEvents()
    func getPatientNames(dentID: String)
    var names: Observable<[PatientNames]?> { get  set } //1
    var events: Observable<Events?> { get  set }
    func setError(_ message: MyCustomError)
    var success: Observable<Bool> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class CalenderViewModel : CalenderViewModelProtocol{
   
    
   
    
    var names: Observable<[PatientNames]?> = Observable(nil)
    
    var events: Observable<Events?> =  Observable(nil)
    
    var success: Observable<Bool>             = Observable(false)
    var errorMessage: Observable<MyCustomError?>    = Observable(nil)
    var error: Observable<Bool>               = Observable(false)
    var isLoading: Observable<Bool>           = Observable(false)
    var addedVisit: Observable<Calender?>     = Observable(nil)
    var addedEvent: Observable<Calender?>     = Observable(nil)
    var sucessMessage: Observable<String?>    = Observable(nil)
    

    var api:CalenderAPIProtocol?
    init(){
        self.api = CalenderAPI()
    }
    
    func AddVisit(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String) {
            isLoading.value = true
            self.api?.addVisit(patientID: patientID, title: title, type: type ,visit_status: visit_status,visit_type: visit_type,start: start, end: end ,cost:cost, completion: { result in
                self.isLoading.value = false
                switch result {
                case .success(let data):
                    self.success.value = true
                    self.sucessMessage.value = data?.message
                case .failure(let error):
                    print(error)
                    self.setError(error)
                    self.success.value = false
                }
            })
    }
    
    
    func AddEvent(patientID: Int, title: String, type: String ,visit_status: String,visit_type: String,start: String, end: String ,cost:String) {
        isLoading.value = true
        self.api?.addEvent(patientID: patientID, title: title, type: type ,visit_status: visit_status,visit_type: visit_type,start: start, end: end ,cost:cost, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(_):
                self.success.value = true
            case .failure(let error):
                print(error)
                self.setError(error)
                self.success.value = false
            }
        })
    }
    
    
    func getEvents() {
        self.isLoading = Observable(true)
        api?.getEvents(completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.events.value = result?.data
            case .failure(let error):
                print(error.message)
                
            }
        })
    }
    
    func getPatientNames(dentID: String) {
        self.isLoading = Observable(true)
        api?.getPatientNames(dentID: dentID ,completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.names.value = result?.data
            case .failure(let error):
                print(error.message)
                
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
