//
//  RegisterVC.swift
//  lnkr-patient
//
//  Created by MohamedNajeh on 22/01/2023.
//

import UIKit
import DropDown

class RegisterVC: UIViewController {
    
    @IBOutlet weak var fullNameLbl: CustomTextField!
    @IBOutlet weak var mobileNumberLbl: CustomTextField!
    @IBOutlet weak var birthDateTxtField: CustomTextField!
    @IBOutlet weak var nationalityTxtField: CustomTextField!
    @IBOutlet weak var passwordTxtField: CustomTextField!
    @IBOutlet weak var cardNumberTxtField: CustomTextField!
    @IBOutlet weak var pinCodeTxtField: CustomTextField!
    
    @IBOutlet weak var emailAddressTextFieldOutlet: CustomTextField!
    @IBOutlet weak var maleBtnOutlet: UIButton!
    @IBOutlet weak var femaleBtnOutlet: UIButton!
    @IBOutlet weak var arabicFullnameTextField: CustomTextField!
    
    @IBOutlet weak var cityBu: UIButton!
    
    var gender = -1
    var viewModel = RegisterViewModel()
    var citis:[String]?
    
    let citisDropDown  = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        mobileNumberLbl.delegate = self
        nationalityTxtField.delegate = self
        viewModel.getCities()
        // Do any additional setup after loading the view.
    }
    
    func bindData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading{
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.successMesage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: true, cancelHandler: nil, actionTitle: "OK", actionStyle: .default) { _ in
                self.dismiss(animated: true)
            }
        }
        
        viewModel.errorMessage.bind { error in
            AlertsManager.showAlert(withTitle: "ERROR", message: error?.message, viewController: self)
        }
        
        viewModel.cities.bind { cities in
            guard let cities = cities else { return }
            self.citis = cities.map { $0.label }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if fullNameLbl.text?.isEmpty ?? true || arabicFullnameTextField.text?.isEmpty ?? true || mobileNumberLbl.text?.isEmpty ?? true ||  nationalityTxtField.text?.isEmpty ?? true || passwordTxtField.text?.isEmpty ?? true  || emailAddressTextFieldOutlet.text?.isEmpty ?? true  {
            AlertsManager.showAlert(withTitle: "ERROR", message: "Please fill all fields with required data", viewController: self)
        }else{
            
            let params = [
                "user_data": [
                    "mobile": "0\(mobileNumberLbl.text?.removingOccurrences(of: " ") ?? "")",
                    "email": emailAddressTextFieldOutlet.text ?? "",
                    "password": passwordTxtField.text ?? "",
                    "national_id": nationalityTxtField.text?.removingOccurrences(of: " ") ?? ""
                ],
                "dentist": [
                    "full_name_en": fullNameLbl.text ?? "",
                    "full_name_ar":arabicFullnameTextField.text ?? "",
                    "city": cityBu.titleLabel?.text ?? "cairo"
                ]
            ]
            
            viewModel.register(params: params)
            
        }
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            print("male")
            self.gender = 1
            sender.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            self.femaleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        case 2:
            print("Female")
            self.gender = 0
            self.maleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            sender.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        default:
            print("")
        }
    }
    
    @IBAction func cityBuPressed(_ sender: UIButton) {
        citisDropDown.dataSource                   = citis ?? []
        citisDropDown.anchorView                   = cityBu
        citisDropDown.bottomOffset                 = CGPoint(x: 0.0, y: cityBu.frame.size.height)
        citisDropDown.direction                    = .bottom
        citisDropDown.show()
        citisDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumberLbl {
            if string == "" {
                // Backspace was pressed
                return true
            }
            let currentText = mobileNumberLbl.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.count == 3 ||  newText.count == 8{
                textField.text = newText + " "
                return false
            }
            
            if newText.removingOccurrences(of: " ").count < 11 {
                return true
            }
        }else if textField == nationalityTxtField {
            if string == "" {
                // Backspace was pressed
                return true
            }
            let currentText = nationalityTxtField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.count == 1 || newText.count == 4 || newText.count == 7 || newText.count == 10 || newText.count == 13 || newText.count == 17 {
                textField.text = newText + " "
                return false
            }
            
            if newText.removingOccurrences(of: " ").count < 15 {
                return true
            }
        }
        return false
    }
}
