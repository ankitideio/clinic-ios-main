//
//  RequestsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//

import Foundation

protocol RequestsViewModelProtocol {
    func getRequests(dentistID:String)
    func addRequests(dentistID:String,title:String,body:String)
    func setError(_ message: MyCustomError)
    var requests: Observable<Requests?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var sucessMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    var sucess: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class RequestsViewModel : RequestsViewModelProtocol{
   
   
    var requests: Observable<Requests?>              = Observable(nil)
    
    var errorMessage: Observable<MyCustomError?>           = Observable(nil)
    
    var sucessMessage: Observable<String?>           = Observable(nil)
    
    var error: Observable<Bool>                      = Observable(false)
    
    var sucess: Observable<Bool>                     = Observable(false)
    
    var isLoading: Observable<Bool>                  = Observable(false)
    
    var api:RequestsAPIProtocol?
    
    init(){
        self.api = RequestsAPI()
    }
    
    func getRequests(dentistID: String) {
        self.isLoading.value = true
        self.api?.getRequests(dentistID: dentistID, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.requests.value = data
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    func addRequests(dentistID: String, title: String, body: String) {
        self.isLoading.value = true
        self.api?.addRequest(dentistID: dentistID, title: title, body: body, completion: { result in
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
