//
//  AddRequestVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//

import UIKit

protocol AddRequestProtocol {
    func addRequest()
}

class AddRequestVC: UIViewController {

    @IBOutlet weak var bodyTF: CustomTextField!
    @IBOutlet weak var titleTF: CustomTextField!
    
    var viewModel = RequestsViewModel()
    var delegate:AddRequestProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        binData()

        // Do any additional setup after loading the view.
    }
    
    func binData(){
        
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: true, cancelHandler: nil, actionTitle: "OK", actionStyle: .default) { _ in
                self.delegate?.addRequest()
                self.dismiss(animated: true)
            }
            
        }
        
        viewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: error.message, viewController: self)
        }
    }
  
    @IBAction func submitBtnPressed(_ sender: Any) {
        viewModel.addRequests(dentistID: "\(General.getUserID())", title: titleTF.text ?? "", body: bodyTF.text ?? "")
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
