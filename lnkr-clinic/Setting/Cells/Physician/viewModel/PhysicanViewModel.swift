//
//  PhysicanViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 02/12/2022.
//

import Foundation

protocol PhysicanViewModelProtocol {
    func updateDentist(dentistID:String,details:[String:Any])
    func updateDentistPricing(params:[String:Any])
    func updatePassword(oldPassword:String,newPassword:String)
    func setError(_ message: MyCustomError)
    var details: Observable<UserInfo?> { get  set } //1
    var dentistInfo: Observable<DentistInfo?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var sucess: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PhysicanViewModel : PhysicanViewModelProtocol{
    
    var dentistInfo: Observable<DentistInfo?>     = Observable(nil)
    
    
    var details: Observable<UserInfo?>            = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>        = Observable(nil)
    
    var error: Observable<Bool>                   = Observable(false)
    
    var sucess: Observable<Bool>                  = Observable(false)
    
    var isLoading: Observable<Bool>               = Observable(false)
    
    var sucessMessage: Observable<String?>        = Observable(nil)
    
    var api:PhysicanAPIProtocol?
    
    init(){
        self.api = PhysicanAPI()
    }
    
    func updateDentist(dentistID: String, details: [String : Any]) {
        self.isLoading.value = true
        self.api?.updateDentist(dentistID: dentistID, details: details, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.sucess.value = true
                self?.sucessMessage.value = data?.message
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func updateDentistPricing(params: [String : Any]) {
        self.isLoading.value = true
        self.api?.updateDentistPricing(params: params, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.sucessMessage.value = data?.message
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    
    func updatePassword(oldPassword: String, newPassword: String) {
        self.isLoading.value = true
        self.api?.updatePassword(oldPassword: oldPassword, newPassword: newPassword, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.sucessMessage.value = data?.message
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func getDentistInfo() {
        self.isLoading.value = true
        self.api?.getDentistInfo { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.dentistInfo.value = data
            case .failure(let error):
                self.setError(error)
            }
        }
    }
    
    
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage.value = message
    }
}
