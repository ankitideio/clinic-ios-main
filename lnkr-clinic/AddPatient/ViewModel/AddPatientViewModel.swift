//
//  AddPatientViewModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 19/11/2022.
//

import Foundation
import UIKit

protocol AddPatientViewModelProtocol {
    func AddPatient(fullName: String, birthdate:String , mobile: String , nationalID: String , gender: Int , pinCode: String , bloodType: String , drugAllergy: String , foodAllergy: String)
    func setError(_ message: MyCustomError)
    var success: Observable<Bool> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class AddPatientViewModel : AddPatientViewModelProtocol{
    
    
    var success: Observable<Bool>         = Observable(false)
    var errorMessage: Observable<MyCustomError?> = Observable(nil)
    var error: Observable<Bool>           = Observable(false)
    var isLoading: Observable<Bool>       = Observable(false)
    var api:AddPatientAPIProtocol?
    init(){
        self.api = AddPatientAPI()
    }
    
    func AddPatient(fullName: String, birthdate:String , mobile: String , nationalID: String , gender: Int , pinCode: String , bloodType: String , drugAllergy: String , foodAllergy: String) {
            isLoading.value = true
            self.api?.AddPatient(fullName: fullName, birthdate: birthdate, mobile: mobile, nationalID: nationalID, gender: gender, pinCode: pinCode, bloodType: bloodType, drugAllergy: drugAllergy, foodAllergy: foodAllergy, completion: { result in
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
    
    func setError(_ message: MyCustomError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
