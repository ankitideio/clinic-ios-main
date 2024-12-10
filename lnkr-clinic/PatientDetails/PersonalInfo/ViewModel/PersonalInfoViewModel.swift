//
//  PersonalInfoViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation
import Alamofire
protocol PersonalInfoViewModelProtocol {
    func fetchInfo(patientID:Int)
    func setError(_ message: MyCustomError)
    var patientInfo: Observable<PersonalInfo?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var successUpdate: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PersonalInfoViewModel: PersonalInfoViewModelProtocol {
  
    
    var patientInfo: Observable<PersonalInfo?> = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>       = Observable(nil)
    
    var error: Observable<Bool>                = Observable(false)
    
    var isLoading: Observable<Bool>            = Observable(false)
    var successUpdate: Observable<String?>     = Observable(nil)
    var api:PersonalInfoAPIProtocol?
    
    init(){
        self.api = PersonalInfoAPI()
    }
    func fetchInfo(patientID: Int) {
        self.isLoading.value = true
        self.api?.getPatientInfo(patientID: patientID, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.patientInfo.value = data?.data
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func updatePatientInfo(patientID:String,patientDetails:[String:String]){
        self.isLoading.value = true
        self.api?.updatePatient(patientID: patientID, patientDetils: patientDetails, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.successUpdate.value = data?.message ?? ""
            case .failure(let error):
                print("iiiii\(error.message)")
                self?.setError(error)
            }
        })
    }
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage.value = message
    }
}
