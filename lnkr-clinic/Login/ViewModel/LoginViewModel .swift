//
//  LoginViewModel .swift
//  LnkrClinic
//
//  Created by Zaki on 05/11/2022.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol {
    func login(email:String,password:String)
    func setError(_ message: MyCustomError)
    var success: Observable<Bool> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class LoginViewModel : LoginViewModelProtocol{
    
    var success: Observable<Bool>         = Observable(false)
    var errorMessage: Observable<MyCustomError?> = Observable(nil)
    var error: Observable<Bool>           = Observable(false)
    var isLoading: Observable<Bool>       = Observable(false)
    var api:LoginAPIProtocol?
    init(){
        self.api = LoginAPI()
    }
    
    func login(email: String, password: String) {
            isLoading.value = true
            self.api?.Login(email: email, password: password, completion: { result in
                self.isLoading.value = false
                switch result {
                case .success(let result):
                    General.setUserData(data: result?.data)
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
