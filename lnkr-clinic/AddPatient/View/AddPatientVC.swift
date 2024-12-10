//
//  AddPatientVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit

class AddPatientVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var DetailsStackView: UIStackView!
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var nationalID: UITextField!
    @IBOutlet weak var bloodType: UITextField!
    @IBOutlet weak var drugAllergy: UITextField!
    @IBOutlet weak var foodAllergy: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var patientPinCode: UITextField!
    @IBOutlet weak var maleImageView: UIImageView!
    @IBOutlet weak var femaleImageView: UIImageView!
    @IBOutlet weak var switchCard: UISwitch!
    @IBOutlet weak var maleBttn: UIButton!
    @IBOutlet weak var femaleBttn: UIButton!
    
    //MARK: - VARIABLES
    var gender = 1
    private let addPatientViewModel = AddPatientViewModel()
    private let getPatientDet : AddPatientUserInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker()
                datePicker.datePickerMode = .date
                datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
                datePicker.frame.size = CGSize(width: 0, height: 300)
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.maximumDate = Date()
                datePicker.locale = Locale(identifier: "en")
                birthdate.inputView = datePicker
                birthdate.text = formatDate(date: Date())
        
       
        
        bindData()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func dateChange(datePicker: UIDatePicker)
        {
            birthdate.text = formatDate(date: datePicker.date)
        }
        
        func formatDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            formatter.locale = Locale(identifier: "en")
            return formatter.string(from: date)
        }
    
    
    
    func bindData(){
        addPatientViewModel.success.bind { isSuccess in
            if isSuccess {
                self.dismiss(animated: true)
                print("success")
            }else{
                print("failure")
            }
        }
        
        addPatientViewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        addPatientViewModel.errorMessage.bind { error in
            AlertsManager.showAlert(withTitle: "ERROR", message: error?.message, viewController: self)
        }
    }
    
    
    @IBAction func maleBttnPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1 :
            maleBttn.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            femaleBttn.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            gender = 1
        case 2 :
            femaleBttn.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            maleBttn.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            gender = 2
        default:
            break
        }
    }
    
    
    @IBAction func switchCardPressed(_ sender: Any) {
        if switchCard.isOn{
            cardNumber.isHidden = false
            patientPinCode.isHidden = false
        }
        else{
            cardNumber.isHidden = true
            patientPinCode.isHidden = true
        }
        
    }
    
    
    @IBAction func cancelBttnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitBttnPressed(_ sender: Any) {
        if mobileNumber.text?.isValidEgyptioanNumber ?? false && nationalID.text?.isValidNationalID ?? false {
            addPatientViewModel.AddPatient(fullName: fullName.text ?? "", birthdate: birthdate.text ?? "" , mobile: mobileNumber.text ?? "", nationalID: nationalID.text ?? "" , gender: gender, pinCode: patientPinCode.text ?? "" , bloodType: bloodType.text ?? "" , drugAllergy: drugAllergy.text ?? "" , foodAllergy: foodAllergy.text ?? "")
        }else{
            AlertsManager.showAlert(withTitle: "ERROR", message: "Please Enter Valid inputs", viewController: self)
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
