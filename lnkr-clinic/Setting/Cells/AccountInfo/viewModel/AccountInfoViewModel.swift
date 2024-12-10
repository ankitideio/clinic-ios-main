//
//  AssistantViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import Foundation

protocol AccountInfoViewModelProtocol {
    func updateAccountInfo(params:[String:Any])
    func setError(_ message: MyCustomError)
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var sucess: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AccountInfoViewModel : AccountInfoViewModelProtocol{
    
    
    
    var errorMessage: Observable<MyCustomError?>      = Observable(nil)
    
    var sucessMessage: Observable<String?>      = Observable(nil)
    
    var error: Observable<Bool>                 = Observable(false)
    
    var sucess: Observable<Bool>                = Observable(false)
    
    var isLoading: Observable<Bool>             = Observable(false)
    
    var api:AccountInfoAPIProtocol?
    
    init(){
        self.api = AccountInfoAPI()
    }
    func updateAccountInfo(params: [String:Any]) {
        self.isLoading.value = true
        self.api?.updateAccountInfo(params: params, completion: { result in
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
