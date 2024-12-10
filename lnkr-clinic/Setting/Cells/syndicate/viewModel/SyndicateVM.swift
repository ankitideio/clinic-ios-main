//
//  SyndicateVM.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/03/2023.
//

import Foundation
protocol SyndicateViewModelProtocol {
    func addSyndicateInfo(params:[String:String])
    func setError(_ message: MyCustomError)
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var sucess: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class SyndicateViewModel : SyndicateViewModelProtocol{
    
    
    var errorMessage: Observable<MyCustomError?>      = Observable(nil)
    
    var sucessMessage: Observable<String?>      = Observable(nil)
    
    var error: Observable<Bool>                 = Observable(false)
    
    var sucess: Observable<Bool>                = Observable(false)
    
    var isLoading: Observable<Bool>             = Observable(false)
    
    var api:SyndicateAPIProtocol?
    
    init(){
        self.api = SyndicateAPI()
    }
    func addSyndicateInfo(params:[String:String]) {
        self.isLoading.value = true
        self.api?.addSyndicateInfo(params: params, completion: { result in
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
