//
//  AddScanViewModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 21/11/2022.
//

import Foundation
import UIKit

protocol AddLabViewModelProtocol {
    func AddLab(labResult: String, labName: String)
    func setError(_ message: NSError)
    var success: Observable<Bool> { get  set } //1
    var errorMessage: Observable<NSError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AddLabViewModel : AddLabViewModelProtocol{
    
    
    var success: Observable<Bool>         = Observable(false)
    var errorMessage: Observable<NSError?> = Observable(nil)
    var error: Observable<Bool>           = Observable(false)
    var isLoading: Observable<Bool>       = Observable(false)
    var api:AddLabAPIProtocol?
    init(){
        self.api = AddLabAPI()
    }
    
    func AddLab(labResult: String, labName:String ) {
            isLoading.value = true
            self.api?.AddLab(labResult: labResult, labName: labName, completion: { result in
                self.isLoading.value = false
                switch result {
                case .success(let result):
                    //print(result)
                   // General.setUserData(data: result?.data)
                    self.success.value = true
                case .failure(let error):
                    print(error)
                    self.setError(error)
                    self.success.value = false
                }
            })
    }
    
    func setError(_ message: NSError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
