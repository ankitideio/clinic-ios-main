//
//  AddPatientsVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class AddPatientsVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var imgVwCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtFldNationalId: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    
    //MARK: - VARIABLES
    var mobileNo = ""
    var nationalId = ""
    var viewModel = AddPatientVM()
    var isSelect = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        txtFldPhone.delegate = self
        txtFldNationalId.delegate = self
    }
    
    //MARK: - ACTIONS
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddPatient(_ sender: UIButton) {
        let newMobile = txtFldPhone.text?.replacingOccurrences(of: " ", with: "")
        mobileNo = "0\(newMobile ?? "")"
        print(mobileNo)
        let newnationalId = txtFldNationalId.text?.replacingOccurrences(of: " ", with: "") ?? ""
        nationalId = newnationalId
        print(nationalId)
        if txtFldName.text == ""{
            showSwiftyAlert("", "Please enter full name", false)
        }else if txtFldPhone.text == ""{
            showSwiftyAlert("", "Please enter mobile number", false)
        }else if txtFldNationalId.text == ""{
            showSwiftyAlert("", "Please enter national id", false)
        }else{
            viewModel.addPatientApi(name: txtFldName.text ?? "", mobile: mobileNo, nationalId: nationalId) {
//                let  AddPatientVC = currentStoryboard(.patientOtp).instantiateViewController(identifier: "PatientOtpVC") as! PatientOtpVC
//                self.navigationController?.pushViewController(AddPatientVC, animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    @IBAction func actionCountryCode(_ sender: UIButton) {
    }
    
}
  
extension AddPatientsVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        if textField == txtFldPhone{
            
            let currentText = textField.text ?? ""
            var newText = (currentText as NSString).replacingCharacters(in: range, with: string)
           
            if newText.count > 12 {
                return false
            }
            var formattedText = newText.replacingOccurrences(of: " ", with: "")
            if  string.count == 1 {
                       formattedText.removeLast()
                   }
           
                if formattedText.count >= 3 {
                    formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 3))
                }
                if formattedText.count >= 8 {
                    formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 8))
                }
            txtFldPhone.text = formattedText
        
            return true
            
        }else{
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.count > 20 {
                return false
            }
            var formattedText = newText.replacingOccurrences(of: " ", with: "")
            if  string.count == 1 {
                    formattedText.removeLast()
                   }
            if formattedText.count >= 1 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 1))
            }
            if formattedText.count >= 4 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 4))
            }
            if formattedText.count >= 7 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 7))
            }
            if formattedText.count >= 10 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 10))
            }
            if formattedText.count >= 13 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 13))
            }
            if formattedText.count >= 17 {
                formattedText.insert(" ", at: formattedText.index(formattedText.startIndex, offsetBy: 17))
            }
            txtFldNationalId.text = formattedText
            
            return true
        }
    }
}
