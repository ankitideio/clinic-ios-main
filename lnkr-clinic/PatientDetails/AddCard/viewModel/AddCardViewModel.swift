//
//  AddCardViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 26/12/2022.
//

import Foundation

protocol AddCardViewModelProtocol {
    func addCard(dentistID:String,patientID:String,cardNumber:String,pinCode:String)
    func setError(_ message: MyCustomError)
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AddCardViewModel : AddCardViewModelProtocol{
    
    
    var errorMessage: Observable<MyCustomError?>  = Observable(nil)
    
    var error: Observable<Bool>             = Observable(false)
    
    var isLoading: Observable<Bool>         = Observable(false)
    
    var api:AddCardAPIProtocol?
    
    init(){
        self.api = AddCardAPI()
    }
    
    func addCard(dentistID: String, patientID: String, cardNumber: String, pinCode: String) {
        self.isLoading.value = true
        self.api?.addCard(dentistID: dentistID, patientID: patientID, cardNumber: cardNumber, pinCode: pinCode, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.error.value = true
        self.errorMessage.value = message
    }
}
