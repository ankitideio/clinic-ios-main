//
//  AddClinicAddressVM.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/03/2023.
//

import Foundation

protocol AddClinicAddressViewModelProtocol {
    func addClinicAddress(params:[String:Any])
    func setError(_ message: MyCustomError)
    var errorMessage: Observable<MyCustomError?> { get set }
    var successMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AddClinicAddressVM : AddClinicAddressViewModelProtocol{
    
    var successMessage: Observable<String?>      = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>  = Observable(nil)
    
    var error: Observable<Bool>             = Observable(false)
    
    var isLoading: Observable<Bool>         = Observable(false)
    
    var api:AddClinicAddressAPIProtocol?
    
    init(){
        self.api = AddClinicAddressAPI()
    }
    
    func addClinicAddress(params:[String:Any]) {
        self.isLoading.value = true
        self.api?.addClinicAddress(params: params, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                //print(data)
                self?.successMessage.value = data?.message
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage.value = message
    }
}
