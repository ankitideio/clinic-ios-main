//
//  MedicalInfoVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class MedicalInfoVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var pickerVw: UIPickerView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtFldFoodAllergy: UITextField!
    @IBOutlet weak var txtFldDrugAllergy: UITextField!
    @IBOutlet weak var txtFldBloodType: UITextField!
    @IBOutlet weak var txtFldAlcohol: UITextField!
    @IBOutlet weak var txtFldSmoking: UITextField!
    @IBOutlet weak var txtFldMaterialStatus: UITextField!
    @IBOutlet weak var txtFldDiabetes: UITextField!
    
    //MARK: - VARIABLES
    var viewModel = PatientInfoVM()
    var alcohol = false
    var smoking = false
    var diabetes = false
    var selectType = ["Yes", "No"]
    var arrMartial = ["Single","Married","Divorced","Widowed"]
    var arrBloodType = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    
    //MARK: - FUNTION
    func uiSet(){
        btnSave.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationMedicalInfo"), object: nil)
        medicalInfoApi()
        txtFldSmoking.delegate = self
        txtFldAlcohol.delegate = self
        txtFldDiabetes.delegate = self
        txtFldMaterialStatus.delegate = self
        txtFldBloodType.delegate = self
        pickerVw.delegate = self
        pickerVw.dataSource = self
        pickerVw.isHidden = true
        
    }
    
    //MARK: - MEDICALINFOAPI
    func medicalInfoApi(){
        viewModel.medicalInfoApi(patientId: Store.patientId ?? 0) { data in
            self.txtFldBloodType.text = data?.bloodType ?? ""
            self.txtFldDrugAllergy.text = data?.drugAllergy ?? ""
            self.txtFldFoodAllergy.text = data?.foodAllergy ?? ""
            self.txtFldMaterialStatus.text = data?.maritalStatus ?? ""
            if data?.alcohol == true {
                self.txtFldAlcohol.text = "Yes"
            }else{
                self.txtFldAlcohol.text = "No"
            }
            if data?.smoking == true {
                self.txtFldSmoking.text = "Yes"
            }else{
                self.txtFldSmoking.text = "No"
            }
            if data?.diabetes == true {
                self.txtFldDiabetes.text = "Yes"
            }else{
                self.txtFldDiabetes.text = "No"
            }
            let initialSelectedRow = self.arrBloodType.firstIndex(of: data?.bloodType ?? "") ?? 0
            self.pickerVw.selectRow(initialSelectedRow, inComponent: 0, animated: true)
        }
    }
    
    //MARK: - GET NOTIFICATIONCENTER DATA
    @objc func methodOfReceivedNotification(notification: Notification) {
        btnSave.isHidden = false
        self.txtFldMaterialStatus.isUserInteractionEnabled = true
        self.txtFldSmoking.isUserInteractionEnabled = true
        self.txtFldAlcohol.isUserInteractionEnabled = true
        self.txtFldBloodType.isUserInteractionEnabled = true
        self.txtFldDrugAllergy.isUserInteractionEnabled = true
        self.txtFldFoodAllergy.isUserInteractionEnabled = true
        self.txtFldDiabetes.isUserInteractionEnabled = true
        self.txtFldMaterialStatus.inputView = pickerVw
        self.txtFldAlcohol.inputView = pickerVw
        self.txtFldSmoking.inputView = pickerVw
        self.txtFldBloodType.inputView = pickerVw
        self.txtFldDiabetes.inputView = pickerVw
    }
    
    //MARK: - ACTION
    @IBAction func actionSave(_ sender: UIButton) {
        if txtFldSmoking.text == "Yes"{
            smoking = true
        }else{
            smoking = false
        }
        if txtFldAlcohol.text == "Yes"{
            alcohol = true
        }else{
            alcohol = false
        }
        if txtFldDiabetes.text == "Yes"{
            diabetes = true
        }else{
            diabetes = false
        }
        if txtFldMaterialStatus.text == ""{
            showSwiftyAlert("", "Please enter your martial status", false)
        }else if txtFldSmoking.text == ""{
            showSwiftyAlert("", "Please select smoking", false)
        }else{
            viewModel.updateMedicalInfoApi(materialStatus: txtFldMaterialStatus.text ?? "", smoking: smoking, alcohol: alcohol, bloodType: txtFldBloodType.text ?? "", drugAllergy: txtFldDrugAllergy.text ?? "", foodAllergy: txtFldFoodAllergy.text ?? "", diabetes: self.diabetes) { data in
                self.medicalInfoApi()
                self.btnSave.isHidden = true
                self.txtFldMaterialStatus.isUserInteractionEnabled = false
                self.txtFldSmoking.isUserInteractionEnabled = false
                self.txtFldAlcohol.isUserInteractionEnabled = false
                self.txtFldBloodType.isUserInteractionEnabled = false
                self.txtFldDrugAllergy.isUserInteractionEnabled = false
                self.txtFldFoodAllergy.isUserInteractionEnabled = false
                NotificationCenter.default.post(name: Notification.Name("NotificationEdit"), object: nil)
            }
        }
        
    }
}

//MARK: - TEXTFIELD DELEGATE METHOD
extension MedicalInfoVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerVw.isHidden = false
        if textField == txtFldAlcohol {
            type = "Alcohol"
        }else if textField == txtFldSmoking {
            type = "Smoking"
        }else if textField == txtFldDiabetes {
            type = "Diabetes"
        }else if textField == txtFldMaterialStatus{
            type = "MartialStatus"
        }else{
            type = "BloodType"
        }
    }
    
}

//MARK: - PICKERVIEW DELEGATE AND DATASOURCE METHOD
extension MedicalInfoVC: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if type == "MartialStatus"{
            return arrMartial.count
        }else if type == "BloodType"{
            return arrBloodType.count
        }else{
            return selectType.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if type == "MartialStatus"{
            return arrMartial[row]
        }else if type == "BloodType"{
            return arrBloodType[row]
        }else{
            return selectType[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if type == "Alcohol"{
            txtFldAlcohol.text = "\(selectType[row])"
        }else if type == "Smoking"{
            txtFldSmoking.text = "\(selectType[row])"
        }else if type == "Diabetes"{
            txtFldDiabetes.text = "\(selectType[row])"
        }else if type == "BloodType"{
            txtFldBloodType.text = "\(arrBloodType[row])"
        }else{
            txtFldMaterialStatus.text = "\(arrMartial[row])"
        }
        
    }
}
