//
//  AddWorkingDaysViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 07/03/2023.
//

import Foundation
protocol AddWorkingDaysViewModelProtocol {
    func AddWorkingDay(params: [String:Any])
    func setError(_ message: MyCustomError)
    var success: Observable<String?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AddWorkingDaysViewModel : AddWorkingDaysViewModelProtocol{
    
    
    var success: Observable<String?>         = Observable(nil)
    var errorMessage: Observable<MyCustomError?> = Observable(nil)
    var error: Observable<Bool>           = Observable(false)
    var isLoading: Observable<Bool>       = Observable(false)
    var api:AddWorkingDaysAPIProtocol?
    init(){
        self.api = AddWorkingDaysAPI()
    }
    
    func AddWorkingDay(params: [String:Any]) {
        isLoading.value = true
        self.api?.AddWorkingDay(params: params, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let result):
                self.success.value = result?.message
            case .failure(let error):
                print(error)
                self.setError(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
