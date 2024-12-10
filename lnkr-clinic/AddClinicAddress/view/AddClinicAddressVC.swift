//
//  AddClinicAddressVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/03/2023.
//

import UIKit

class AddClinicAddressVC: UIViewController {

    @IBOutlet weak var zipCodeTF: CustomTextField!
    @IBOutlet weak var buildingTF: CustomTextField!
    @IBOutlet weak var streetTF: CustomTextField!
    @IBOutlet weak var cityTF: CustomTextField!
    
    let viewModel = AddClinicAddressVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData(){
        viewModel.isLoading.bind { loading in
            switch loading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.successMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self)
        }
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: message.message, viewController: self)
        }
    }
  
    @IBAction func submitAddress(_ sender: Any) {
        let params = [
            "address": [
                "zip_code": zipCodeTF.text,
                "building": buildingTF.text,
                "street": streetTF.text,
                "city": cityTF.text
            ]
        ]
        
        viewModel.addClinicAddress(params: params)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
