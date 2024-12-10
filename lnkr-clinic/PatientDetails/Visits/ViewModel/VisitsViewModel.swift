//
//  VisitsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 16/11/2022.
//

import Foundation


protocol VisitsViewModelProtocol {
    func fetcVisits(userID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var visits: Observable<[VisitModel]?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
    var page: Observable<Page?> { get  set } //1
}

class VisitsViewModel : VisitsViewModelProtocol{
    
    var visits: Observable<[VisitModel]?>     = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>  = Observable(nil)
    
    var error: Observable<Bool>             = Observable(false)
    
    var isLoading: Observable<Bool>         = Observable(false)
    var page: Observable<Page?>             = Observable(nil)
    var api:VisitsAPIProtocol?
    
    init(){
        self.api = VisitsAPI()
    }
    
    func fetcVisits(userID: Int, page: Int) {
        self.isLoading.value = true
        self.api?.getVisits(userID: userID, page: page, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let result):
                //print(result)
                self.visits.value = result?.data
                self.page.value   = result?.page
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
