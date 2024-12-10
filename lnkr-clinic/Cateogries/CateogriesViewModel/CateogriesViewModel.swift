//
//  CateogriesViewModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 26/11/2022.
//

import Foundation

protocol CateogriesViewModelProtocol {
    func fetchCateogries(clinicID : String)
    func setError(_ message: MyCustomError)
    var cateogries: Observable<[Cateogry]?> { get  set } //1
    var addedCateogry: Observable<Cateogry?> { get  set } //1
    var deletedCateogry: Observable<Cateogry?> { get  set }
    var successMessage: Observable<String?> { get set }
    var successDeleteMessgae: Observable<String?> { get set }
    var errorMessage: Observable<MyCustomError?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class CateogriesViewModel: CateogriesViewModelProtocol {
    
 
    var cateogries: Observable<[Cateogry]?>         = Observable(nil)
    
    var addedCateogry: Observable<Cateogry?>        = Observable(nil)
    var deletedCateogry: Observable<Cateogry?>      = Observable(nil)

    var errorMessage: Observable<MyCustomError?>          = Observable(nil)
    var error: Observable<Bool>                     = Observable(false)
    var isLoading: Observable<Bool>                 = Observable(false)
    var successMessage: Observable<String?>         = Observable(nil)
    var successDeleteMessgae: Observable<String?>   = Observable(nil)
    var api:CateogriesAPIProtocol?
    
    init(){
        self.api = CateogriesAPI()
    }
    
    func fetchCateogries(clinicID: String) {
        self.isLoading = Observable(true)
        api?.getCateogriess(clinicID: clinicID ,completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.cateogries.value = result?.data
            case .failure(let error):
                print(error.message)
                
            }
        })
    }
    
    
    func addCateogry(clinicID: String ,name:String) {
        self.isLoading.value = true
        self.api?.addCateogry(clinicID: clinicID ,name: name, completion: { result in
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.successMessage.value = data?.message
                self.error.value = false
            case .failure(let error):
                self.setError(error)
            }
        })
    }
    
    
    func deleteCateogry(clinicID: String , cateogryID: String) {
        self.isLoading.value = true
        api?.deleteCateogry(clinicID: clinicID ,cateogrID: cateogryID ,completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let result):
                self?.deletedCateogry.value = result?.data
                self?.successDeleteMessgae.value = result?.message
            case .failure(let error):
                print(error.message)
                
            }
        })
    }
    
    
    func setError(_ message: MyCustomError) {
        
    }
    
}
