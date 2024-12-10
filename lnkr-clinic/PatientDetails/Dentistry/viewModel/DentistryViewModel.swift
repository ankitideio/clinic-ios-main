//
//  DentistryViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

protocol DentistryViewModelProtocol {
    func fetcDentistries(userID:Int)
    func setError(_ message: MyCustomError)
    var Dentistries: Observable<[Dentistry]?> { get  set } //1
    var errorMessage: Observable<MyCustomError?>? { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class DentistryViewModel : DentistryViewModelProtocol {
   
    
    var Dentistries: Observable<[Dentistry]?>    = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>?
    
    var error: Observable<Bool>                  = Observable(false)
    
    var isLoading: Observable<Bool>              = Observable(false)
    var api:DentistryAPIProtocol?
    
    init(){
        self.api = DentistryAPI()
    }
    
    func fetcDentistries(userID: Int) {
        self.isLoading.value = true
        self.api?.getVisits(patientID: userID, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.Dentistries.value = data
            case .failure(let error):
                self.setError(error)
            }
        })
        
    }
    
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage?.value = message
    }
    
}
