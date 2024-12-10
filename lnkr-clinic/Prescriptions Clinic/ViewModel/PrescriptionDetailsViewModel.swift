//
//  PrescriptionDetailsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 22/11/2022.
//

import Foundation

protocol PrescriptionDetailsViewModelProtocol {
    func fetccDetails(uuid:String)
    func setError(_ message: MyCustomError)
    var prescription: Observable<Details?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PrescriptionDetailsViewModel : PrescriptionDetailsViewModelProtocol{
  
    
    var prescription: Observable<Details?>      = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>      = Observable(nil)
    
    var error: Observable<Bool>                 = Observable(false)
    
    var isLoading: Observable<Bool>             = Observable(false)
    var api:PrescriptionDetailsAPIProtocol?
    
    init(){
        self.api = PrescriptionDetailAPI()
    }
    func fetccDetails(uuid: String) {
        self.isLoading.value = true
        self.api?.getPrescriptionDetails(uuid: uuid, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                //print(data)
                self.prescription.value = data
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
