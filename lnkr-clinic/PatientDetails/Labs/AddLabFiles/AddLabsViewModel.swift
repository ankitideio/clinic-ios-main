//
//  AddLabsViewModel.swift
//  lnkr-clinic
//
//  Created by Zaki on 23/11/2022.
//

import Foundation

class AddLabsViewModel : NSObject {
    
    var imageData = Data()
     var lab : AddLabModelResponse?
     private var apiDataSource : AddLabDataSource!
     var onSucsess: ((_ message: String) -> Void)?
     var onAddLabFailed: ((_ message: String) -> Void)?
     var showAlert : ((_ showAlert : String) -> Void)?
     var OnAddLabSucsess : ((_ labs : AddLabModelResponse?) -> Void)?
     var isLoading: ((_ isLoading: Bool) -> Void)?
    
    override init() {
        super.init()
        self.apiDataSource = AddLabDataSource()
    }
    
    func AddLab(File fileData: Data ,url:String ,WithName fileName:String ,  labName : String,quryItem:String,patientID:String ){
        self.isLoading?(true)
        apiDataSource.AddLab(File: imageData,url: url ,patientID: patientID, WithName: fileName ,labName: labName,quryItem: quryItem , isSucess: {
            [weak self] lab in
            self?.isLoading?(false)
            guard let response = lab else {
                return
            }
            
            self?.OnAddLabSucsess?(response)

            if lab?.success == true {
                self?.onSucsess?(response.message ?? "")
            }
            else {
                self?.showAlert?(response.message ?? "")
            }

        },
        isError: { [weak self] message in
            self?.onAddLabFailed?(message)
        })
    }
}
