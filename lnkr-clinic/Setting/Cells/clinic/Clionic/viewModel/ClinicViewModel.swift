//
//  ClinicViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import Foundation

protocol ClinicViewModelProtocol {
    func readClinic(clinicID:String)
    func updateClinic(clinicID:String,params:[String:Any])
    func setError(_ message: MyCustomError)
    var details: Observable<Cliniccc?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var sucess: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class ClinicViewModel : ClinicViewModelProtocol{
   
    var details: Observable<Cliniccc?>            = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>        = Observable(nil)
    
    var sucessMessage: Observable<String?>        = Observable(nil)
    
    var error: Observable<Bool>                   = Observable(false)
    
    var sucess: Observable<Bool>                  = Observable(false)
    
    var isLoading: Observable<Bool>               = Observable(false)
    
    var api:ClinicAPIProtocol?
    
    init(){
        self.api = ClinicAPI()
    }
    
    func readClinic(clinicID: String) {
        self.isLoading.value = true
        self.api?.readClinic(clinicID: clinicID, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.details.value = data?.data
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func updateClinic(clinicID: String, params: [String : Any]) {
        self.isLoading.value = true
        self.api?.updateClinic(clicnicID: clinicID, params: params, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.sucessMessage.value = data?.message
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
