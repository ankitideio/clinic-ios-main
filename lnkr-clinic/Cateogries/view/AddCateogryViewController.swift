//
//  AddCateogryViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 26/11/2022.
//

import UIKit

protocol AddCateogryProtocol {
    func refreshCategories()
}
class AddCateogryViewController: UIViewController {
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    let viewModel = CateogriesViewModel()
    var delegate:AddCateogryProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
       bindData()
        // Do any additional setup after loading the view.
    }
    
    func bindData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.errorMessage.bind { message in
            AlertsManager.showAlert(withTitle: "Error", message: message?.message, viewController: self)
        }
        
        viewModel.successMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func submitBttnPressed(_ sender: Any) {
        if nameTxtField.text?.isEmpty ?? false{
            AlertsManager.showAlert(withTitle: "Error", message: "Please enter name", viewController: self)
        }
        else{
            viewModel.addCateogry(clinicID: General.getClinicID(), name: nameTxtField.text ?? "")
            self.delegate?.refreshCategories()
        }
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
