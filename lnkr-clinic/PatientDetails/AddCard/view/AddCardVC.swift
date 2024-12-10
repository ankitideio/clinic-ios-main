//
//  AddCardVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/12/2022.
//

import UIKit

class AddCardVC: UIViewController {

    @IBOutlet weak var pinCodeCntrLbl: UILabel!
    @IBOutlet weak var cardNumberCounterLbl: UILabel!
    @IBOutlet weak var pinCodeTF: UITextField!
    @IBOutlet weak var cardNumberTF: UITextField!
    
    let viewModel = AddCardViewModel()
    var patientID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        cardNumberTF.delegate = self
        pinCodeTF.delegate = self
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
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: "error", viewController: self)
        }
    }

    @IBAction func submitBtnPressed(_ sender: Any) {
        viewModel.addCard(dentistID: "\(General.getUserID())", patientID: "\(patientID)", cardNumber: cardNumberTF.text ?? "", pinCode: pinCodeTF.text ?? "")
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension AddCardVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == cardNumberTF {
            let oldText = cardNumberTF.text!
            let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
            
            
            if newText.count<=16 { cardNumberCounterLbl.text = "\(newText.count)/16" }
            
            
            if newText.count > 16{ return false }
            else{ return true }
        }else if textField == pinCodeTF {
            let oldText = pinCodeTF.text!
            let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
            
            
            if newText.count<=4 { pinCodeCntrLbl.text = "\(newText.count)/4" }
            
            
            if newText.count > 4{ return false }
            else{ return true }
        }
        return false
    }
}
