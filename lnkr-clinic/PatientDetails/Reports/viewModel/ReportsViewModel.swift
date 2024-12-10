//
//  ReportsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

protocol ReportsViewModelProtocol {
    func fetcReports(patientID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var reports: Observable<[Report]?> { get  set } //1
    var addedReport: Observable<Report?> { get  set } //1
    var page: Observable<Page?> {get set}
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class ReportsViewModel : ReportsViewModelProtocol {
  
    
    var reports: Observable<[Report]?>        = Observable(nil)
    
    var page: Observable<Page?>               = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>    = Observable(nil)
    
    var error: Observable<Bool>               = Observable(false)
    
    var isLoading: Observable<Bool>           = Observable(false)
    var addedReport: Observable<Report?>     = Observable(nil)
    var api : ReportsAPIProtocol?
    
    init(){
        self.api = ReportsAPI()
    }
    
    func fetcReports(patientID: Int, page: Int) {
        self.isLoading = Observable(true)
        self.api?.getReports(patientID: patientID, page: page, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.reports.value = data?.data
                self.page.value = data?.page
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func addReport(patientID:String , title:String , body:String) {
        self.isLoading.value = true
        self.api?.addReport(patientID: patientID, title: title, body: body, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.addedReport.value = data?.data
                self.error.value = false
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage.value = message
    }
}
