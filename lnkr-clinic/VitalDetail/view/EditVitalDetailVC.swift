//
//  EditVitalDetailVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 26/04/23.
//

import UIKit

class EditVitalDetailVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblBmi: UILabel!
    @IBOutlet weak var txtFldOther: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var txtFldBmi: UITextField!
    @IBOutlet weak var txtFldPulse: UITextField!
    @IBOutlet weak var txtFldOxygenSaturation: UITextField!
    @IBOutlet weak var txtFldSugarLevel: UITextField!
    @IBOutlet weak var txtFldTemprature: UITextField!
    @IBOutlet weak var txtFldBloodPressure: UITextField!
    @IBOutlet weak var txtFldHeight: UITextField!
    @IBOutlet weak var txtFldWeight: UITextField!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var txtFldRace: UITextField!
    
    //MARK: - VARIABLES
    var isComing = 0
    var callBack:(()->())?
    var viewModel = PatientInfoVM()
    var createdDate = ""
    var uuid = ""
    var height = Double()
    var index = 0
    var arrVital = [VitalRecordData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
    }
    
    //MARK: - FUNCTION
    func uiSet(){
        editVital()
        txtFldHeight.delegate = self
        if isComing == 0{
            btnEdit.isHidden = true
            btnUpdate.isHidden = false
            lblBmi.isHidden = true
            txtFldBmi.isHidden = true
            btnUpdate.setTitle("Add", for: .normal)
        }else if isComing == 1{
            btnEdit.isHidden = true
            btnUpdate.isHidden = true
            lblBmi.isHidden = false
            txtFldBmi.isHidden = false
            vitalDetail()
        }else{
            btnEdit.isHidden = true
            btnUpdate.isHidden = false
            lblBmi.isHidden = false
            txtFldBmi.isHidden = false
            btnUpdate.setTitle("Update", for: .normal)
            vitalDetail()
        }
        
    }
    
    func vitalDetail(){
        self.txtFldWeight.text = arrVital[index].weight ?? ""
        self.txtFldBloodPressure.text = arrVital[index].bloodPressure ?? ""
        self.txtFldTemprature.text = arrVital[index].temperature ?? ""
        self.txtFldSugarLevel.text = arrVital[index].sugarLevel ?? ""
        self.txtFldOxygenSaturation.text = arrVital[index].oxygenSaturation ?? ""
        self.txtFldPulse.text = arrVital[index].pulse ?? ""
        self.txtFldBmi.text = "\(arrVital[index].bmi ?? 0)"
        let lengthInM = Double(arrVital[index].height ?? "") ?? 0
        let lengthInCm = convertMToCm(lengthInM)
        let height = Int(lengthInCm)
        self.txtFldHeight.text = "\(lengthInM)"
    }
    
    func editVital(){
        if isComing == 1{
            self.txtFldHeight.isUserInteractionEnabled = false
            self.txtFldWeight.isUserInteractionEnabled = false
            self.txtFldBloodPressure.isUserInteractionEnabled = false
            self.txtFldTemprature.isUserInteractionEnabled = false
            self.txtFldSugarLevel.isUserInteractionEnabled = false
            self.txtFldOxygenSaturation.isUserInteractionEnabled = false
            self.txtFldPulse.isUserInteractionEnabled = false
            self.txtFldBmi.isUserInteractionEnabled = false
            self.txtFldRace.isUserInteractionEnabled = false
            self.txtFldOther.isUserInteractionEnabled = false
        }else{
            self.txtFldHeight.isUserInteractionEnabled = true
            self.txtFldWeight.isUserInteractionEnabled = true
            self.txtFldBloodPressure.isUserInteractionEnabled = true
            self.txtFldTemprature.isUserInteractionEnabled = true
            self.txtFldSugarLevel.isUserInteractionEnabled = true
            self.txtFldOxygenSaturation.isUserInteractionEnabled = true
            self.txtFldPulse.isUserInteractionEnabled = true
            self.txtFldBmi.isUserInteractionEnabled = false
            self.txtFldRace.isUserInteractionEnabled = true
            self.txtFldOther.isUserInteractionEnabled = true
        }
    }
    
    
    //MARK: - ACTIONS
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.callBack?()
    }
    @IBAction func actionEdit(_ sender: UIButton) {
        btnEdit.isHidden = true
        btnUpdate.isHidden = false
        isComing = 2
        editVital()
        btnUpdate.setTitle("Update", for: .normal)
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        let lengthInCm = Double(txtFldHeight.text ?? "") ?? 0
//        let lengthInM = convertCmToM(lengthInCm)
        self.height = lengthInCm
        if isComing == 2{
            if txtFldWeight.text == ""{
                showSwiftyAlert("", "Please enter your weight", false)
            }else if txtFldHeight.text == ""{
                showSwiftyAlert("", "Please enter your height", false)
            }else{
                viewModel.addVitalDetail(weight: txtFldWeight.text ?? "", height: self.height, bloodPressure: txtFldBloodPressure.text ?? "", temprature: txtFldTemprature.text ?? "", sugarLevel: txtFldSugarLevel.text ?? "", oxygenSaturation: txtFldOxygenSaturation.text ?? "", pulse: txtFldPulse.text ?? "",race: txtFldRace.text ?? "",other: txtFldOther.text ?? "") {
              
                        self.navigationController?.popViewController(animated: true)
                    
                    self.callBack?()
                }

            }
        }else{
            if txtFldWeight.text == ""{
                showSwiftyAlert("", "Please enter your weight", false)
            }else if txtFldHeight.text == ""{
                showSwiftyAlert("", "Please enter your height", false)
            }else{
                viewModel.updateVitalDetail(weight: txtFldWeight.text ?? "", height:self.height, bloodPressure: txtFldBloodPressure.text ?? "", temprature: txtFldTemprature.text ?? "", sugarLevel: txtFldSugarLevel.text ?? "", oxygenSaturation: txtFldOxygenSaturation.text ?? "", pulse: txtFldPulse.text ?? "", bmi: txtFldBmi.text ?? "", createdDate: self.createdDate, uuid: self.uuid,rece: txtFldRace.text ?? "",other: txtFldOther.text ?? ""){
                
                        self.navigationController?.popViewController(animated: true)
                    
                    self.callBack?()
                }
            }
        }
        
    }
}

extension EditVitalDetailVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        let weight = Double(txtFldWeight.text ?? "") ?? 0
        let lengthInCm = Double(txtFldHeight.text ?? "") ?? 0
        let lengthInM = convertCmToM(lengthInCm)
        let bmi = calculateBMI(weight: weight, height: lengthInM)
        let formattedNum = formatDouble(bmi)
        txtFldBmi.text = "\(formattedNum)"
    }
}
