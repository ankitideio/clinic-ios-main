//
//  PINCodeViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/12/2022.
//

import Foundation

protocol PINCodeViewModelProtocol {
    func findPatient(cardNumber:String,pinCode:String)
    func setError(_ message: MyCustomError)
    var patintID: Observable<Int?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PINCodeViewModel : PINCodeViewModelProtocol{
    
    
    var patintID: Observable<Int?>                 = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>         = Observable(nil)
    
    var error: Observable<Bool>                    = Observable(false)
    
    var isLoading: Observable<Bool>                = Observable(false)
    var api:PINCodeAPIProtocol?
    
    init(){
        api = PINCodeAPI()
    }
    
    func findPatient(cardNumber: String, pinCode: String) {
        self.isLoading.value = true
        self.api?.findPatient(cardNumber: cardNumber, pinCode: pinCode, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.patintID.value = data?.data?.patientID
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
