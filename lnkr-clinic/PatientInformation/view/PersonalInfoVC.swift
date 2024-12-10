//
//  PersonalInfoVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit
import Presentr
import IQKeyboardManagerSwift
class PersonalInfoVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var btnNationId: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var txtFldGender: UITextField!
    @IBOutlet weak var btnHasCard: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var vwPinCode: UIView!
    @IBOutlet weak var vwCardNo: UIView!
    @IBOutlet weak var txtFldCardNo: UITextField!
    @IBOutlet weak var vwNationalId: UIView!
    @IBOutlet weak var txtFldNationalId: UITextField!
    @IBOutlet weak var txtFldAge: UITextField!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgVwCountryFlag: UIImageView!
    @IBOutlet weak var txtFldPhoneNo: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldPincode: UITextField!
    
    //MARK: - VARIABLES
    var viewModel = PatientInfoVM()
    var isSavedCard = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
        
    }
    
    //MARK: -  Functions
    func uiSet(){
        btnSave.isHidden = true
        persnalInfoApi()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationPersnalInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfEditNotification(notification:)), name: Notification.Name("EditPatientInfo"), object: nil)
    }
    
    //MARK: - GETNOTIFICATIONCENTERDATA
    @objc func methodOfReceivedNotification(notification: Notification) {
//        vwNationalId.isHidden = false
//        btnSave.isHidden = false
        btnHasCard.isUserInteractionEnabled = true
        txtFldName.isUserInteractionEnabled = false
        txtFldPhoneNo.isUserInteractionEnabled = false
        btnAge.isUserInteractionEnabled = true
        btnNationId.isUserInteractionEnabled = true
        txtFldCardNo.isUserInteractionEnabled = true
        txtFldPincode.isUserInteractionEnabled = true
        btnGender.isUserInteractionEnabled = true
    }
    
    @objc func methodOfEditNotification(notification: Notification) {
           persnalInfoApi()
        btnSave.isHidden = true
    }
    //MARK: - PERSNALINFOAPI
    func persnalInfoApi(){
        viewModel.pesnalInfoApi(patientId: Store.patientId ?? 0) { data in
            self.txtFldName.text = data?.fullName ?? ""
            let originalString = data?.mobile ?? ""
            if originalString.count > 10{
                let newString = String(originalString.dropFirst())
                var newMobile = ""
                for (index, character) in newString.enumerated() {
                    if index % 4 == 3 {
                        newMobile.append(" ")
                    }
                    newMobile.append(character)
                }
                self.txtFldPhoneNo.text = newMobile
            }else{
                var newMobile = ""
                for (index, character) in originalString.enumerated() {
                    if index % 4 == 3 {
                        newMobile.append(" ")
                    }
                    newMobile.append(character)
                }
                self.txtFldPhoneNo.text = newMobile
            }
          
            self.txtFldAge.text = "\(data?.age ?? 0)"
            self.txtFldGender.text = data?.gender ?? ""
           
            let string = data?.nationalID ?? ""

            var formattedString = ""

            for (index, character) in string.enumerated() {
                if index > 0 && index % 2 == 0 {
                    formattedString += " "
                }
                formattedString.append(character)
            }
            self.txtFldNationalId.text = formattedString
            if data?.cardNumber != nil && data?.cardNumber != ""{
                self.btnHasCard.isSelected = true
                self.txtFldCardNo.text = data?.cardNumber ?? ""
                self.txtFldPincode.text = data?.pinCode ?? ""
                self.vwCardNo.isHidden = false
                self.vwPinCode.isHidden = false
                self.isSavedCard = true
            }else{
                self.btnHasCard.isSelected = false
                self.txtFldCardNo.text =  ""
                self.txtFldPincode.text = ""
                self.vwCardNo.isHidden = true
                self.vwPinCode.isHidden = true
                self.isSavedCard = false
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func actionCountryCode(_ sender: UIButton) {
    }
    
    @IBAction func actionHasCard(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            vwCardNo.isHidden = false
            vwPinCode.isHidden = false
            btnSave.isHidden = false
            
        }else{
            vwCardNo.isHidden = true
            vwPinCode.isHidden = true
            btnSave.isHidden = true
        }
    }
    @IBAction func actionAgeBtn(_ sender: UIButton) {
        showSwiftyAlert("", "Kindly update your National ID, under Account", false)
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        if btnHasCard.isSelected == true{
            if txtFldCardNo.text == ""{
                showSwiftyAlert("", "Please enter card number", false)
            }else if txtFldPincode.text == ""{
                showSwiftyAlert("", "Please enter pin code", false)
            }else{
                viewModel.updatePersnalInfoApi(cardNo: txtFldCardNo.text ?? "", pinCode: txtFldPincode.text ?? "") { data in
                    self.persnalInfoApi()
                    self.btnSave.isHidden = true
                    self.btnHasCard.isUserInteractionEnabled = false
                    self.txtFldName.isUserInteractionEnabled = false
                    self.txtFldPhoneNo.isUserInteractionEnabled = false
                    self.btnAge.isUserInteractionEnabled = false
                    self.btnNationId.isUserInteractionEnabled = false
                    self.txtFldCardNo.isUserInteractionEnabled = false
                    self.txtFldPincode.isUserInteractionEnabled = false
                    self.btnGender.isUserInteractionEnabled = false
                    NotificationCenter.default.post(name: Notification.Name("NotificationEdit"), object: nil)
                }
            }
        }else{
            NotificationCenter.default.post(name: Notification.Name("NotificationEdit"), object: nil)
        }
    }
}


