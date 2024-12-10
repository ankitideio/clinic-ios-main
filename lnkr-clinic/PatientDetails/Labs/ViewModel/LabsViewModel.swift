//
//  LabsViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import Foundation
import UIKit
import Alamofire

protocol LabsViewModelProtocol {
    func fetcLabs(patientID:Int,page:Int)
    func setError(_ message: MyCustomError)
    var labs: Observable<[Lab]?> { get  set } //1
    var page: Observable<Page?> {get set}
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class LabsViewModel : LabsViewModelProtocol{
 
    
    var labs: Observable<[Lab]?>             = Observable(nil)
    var page: Observable<Page?>              = Observable(nil)
    var errorMessage: Observable<MyCustomError?>   = Observable(nil)
    
    var error: Observable<Bool>              = Observable(false)
    
    var isLoading: Observable<Bool>          = Observable(false)
    var api:LabsAPIProtocol?
    
    init(){
        self.api = LabsAPI()
    }
    
    func fetcLabs(patientID: Int, page: Int) {
        self.isLoading.value = true
        self.api?.getLabs(patientID: patientID, page: page, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.page.value = data?.page
                self.labs.value = data?.data
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
