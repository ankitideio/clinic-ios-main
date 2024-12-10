//
//  ReigisterViewModel.swift
//  lnkr-patient
//
//  Created by MohamedNajeh on 22/01/2023.
//

import Foundation

protocol RegisterViewModelProtocol {
    func register(params:[String:Any])
    func getCities()
    func setError(_ message: MyCustomError)
    var success: Observable<Bool> { get  set } //1
    var successMesage: Observable<String?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}


class RegisterViewModel : RegisterViewModelProtocol{
  
    
    var success: Observable<Bool>                  = Observable(false)
    
    var errorMessage: Observable<MyCustomError?>   = Observable(nil)
    
    var cities: Observable<Cities?>                = Observable(nil)
    
    var error: Observable<Bool>                    = Observable(false)
    
    var isLoading: Observable<Bool>                = Observable(false)
    
    var successMesage: Observable<String?>         = Observable(nil)
    
    var api:RegisterAPIProtocol?
    
    init(apiService: RegisterAPIProtocol = RegisterAPI()) {
        self.api = apiService
    }
    
    func register(params:[String:Any]) {
        self.isLoading.value = true
        api?.register(params:params, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.success.value = true
                self.successMesage.value = data?.message
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func getCities() {
        api?.getCitites(completion: { result in
            switch result {
            case .success(let cities):
                self.cities.value = cities
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
