//
//  ScansViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation

protocol ScansViewModelProtocol {
    func fetcScans(patientID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var scans: Observable<[Scan]?> { get  set } //1
    var page: Observable<Page?> {get set}
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class ScansViewModel : ScansViewModelProtocol{
  
    
    var scans: Observable<[Scan]?>            = Observable(nil)
    
    var page: Observable<Page?>               = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>    = Observable(nil)
    
    var error: Observable<Bool>               = Observable(false)
    
    var isLoading: Observable<Bool>           = Observable(false)
    var api:ScansAPIProtocol?
    
    init(){
        self.api = ScansAPI()
    }
    
    func fetcScans(patientID: Int, page: Int) {
        self.isLoading = Observable(true)
        self.api?.getScnas(patientID: patientID, page: page, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.page.value = data?.page
                self.scans.value = data?.data
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
