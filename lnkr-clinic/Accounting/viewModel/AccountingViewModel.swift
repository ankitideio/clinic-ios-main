//
//  AccountingViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/12/2022.
//

import Foundation

protocol AccountingViewModelProtocol {
    func getAccounting(dentistID:Int)
    func setError(_ message: MyCustomError)
    var success: Observable<Bool> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
    var accountingList: Observable<Accounting?> { get set }
}


class AccountingViewModel : AccountingViewModelProtocol{
   
    var success: Observable<Bool>               = Observable(false)
    
    var errorMessage: Observable<MyCustomError?>      = Observable(nil)
    
    var error: Observable<Bool>                 = Observable(false)
    
    var isLoading: Observable<Bool>             = Observable(false)
    
    var accountingList: Observable<Accounting?>  = Observable(nil)
    
    var api:AccountingAPIProtocol?
    
    init(){
        api = AccountingAPI()
    }
    
    func getAccounting(dentistID: Int) {
        self.isLoading.value = true
        self.api?.getAccounting(dentistID: dentistID, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.accountingList.value = data
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
