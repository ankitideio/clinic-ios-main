//
//  PrescriptionViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 19/11/2022.
//

import Foundation
import Alamofire
protocol PrescriptionViewModelProtocol {
    func fetcPrescriptions(patientID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var prescriptions: Observable<[Prescription]?> { get  set }
    var insurences: Observable<[Insurence]?> { get  set }//1
    var desease: Observable<[Insurence]?> { get  set }
    var page: Observable<Page?> { get  set }
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PrescriptionViewModel: PrescriptionViewModelProtocol {
   
    var prescriptions: Observable<[Prescription]?>    = Observable(nil)
    var insurences: Observable<[Insurence]?>          = Observable(nil)
    var errorMessage: Observable<MyCustomError?>            = Observable(nil)
    var desease: Observable<[Insurence]?>             = Observable(nil)
    var error: Observable<Bool>                       = Observable(false)
    var page: Observable<Page?>                       = Observable(nil)
    var isLoading: Observable<Bool>                   = Observable(false)
    var api:PrescriptionAPIProtocol?
    
    init(){
        self.api = PrescriptionAPI()
    }
    
    func fetcPrescriptions(patientID: Int, page: Int) {
        self.isLoading = Observable(true)
        self.api?.getPrescription(patientID: patientID, page: page, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.prescriptions.value = data?.data
                self?.page.value          = data?.page
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func fetchInsurences(){
        self.api?.getInsurenves(completion: { result in
            switch result {
            case .success(let data):
                self.insurences.value = data
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func fetchDesease(){
        self.api?.getDesease(completion: { result in
            switch result {
            case .success(let data):
                self.desease.value = data
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func addPrescription(prescription:[String:Any]){
        self.api?.addPrescriptionaddPrescription(prescription: prescription, completion: { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
    func setError(_ message: MyCustomError) {
        error.value = true
        errorMessage.value = message
    }
    
    
}
