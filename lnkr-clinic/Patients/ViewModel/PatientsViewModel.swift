//
//  PatientsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation

protocol PatientsViewModelProtocol {
    func fetchPatients(userID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var patients: Observable<[Patient]?> { get  set } //1
    var page: Observable<Page?> { get  set }
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PatientsViewModel: PatientsViewModelProtocol {
 
    var patients: Observable<[Patient]?>   = Observable(nil)
    var errorMessage: Observable<MyCustomError?> = Observable(nil)
    var error: Observable<Bool>            = Observable(false)
    var isLoading: Observable<Bool>        = Observable(false)
    var page: Observable<Page?>            = Observable(nil)
    var api:PatientsAPIProtocol?
    
    init(){
        self.api = PatientsAPI()
    }
    
    func fetchPatients(userID: Int, page: Int) {
        self.isLoading = Observable(true)
        api?.getPatients(userID: userID, page: page, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.patients.value = result?.data
                self?.page.value      = result?.page
            case .failure(let error):
                print(error.message)
                
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        
    }
    
}
