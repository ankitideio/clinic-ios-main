//
//  HomeViewModel.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchHome(userID:Int)
    func setError(_ message: MyCustomError)
    var homeData: Observable<HomeModel?> { get  set } //1
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var homeData: Observable<HomeModel?>   = Observable(nil)
    var errorMessage: Observable<MyCustomError?> = Observable(nil)
    var error: Observable<Bool>            = Observable(false)
    var isLoading: Observable<Bool>        = Observable(false)
    var api: HomeAPIProtocol?
    
    init() {
        self.api = HomeAPI()
    }

    
    func fetchHome(userID:Int) {
        isLoading = Observable(true)
        self.api?.getHome(userID: userID, completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.homeData.value = result?.data
                self?.error.value = false
            case .failure(let error):
                print(error.message)
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: MyCustomError) {
        self.errorMessage.value = message
        self.error.value        = true
    }
}
