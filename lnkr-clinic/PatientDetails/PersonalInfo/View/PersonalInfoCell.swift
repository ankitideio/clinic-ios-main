//
//  PersonalInfoCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit
import Presentr
class PersonalInfoCell: UITableViewCell {

    @IBOutlet weak var patientImgV: UIImageView!
    @IBOutlet weak var fullNameTF: CustomTextField!
    @IBOutlet weak var mobileNumberTF: CustomTextField!
    @IBOutlet weak var birthDateTF: CustomTextField!
    @IBOutlet weak var maleBtnOutlet: UIButton!
    @IBOutlet weak var femaleBtnOutlet: UIButton!
    @IBOutlet weak var nationalIDTF: CustomTextField!
    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet weak var hasCardTF: CustomTextField!
    @IBOutlet weak var drugTypeOutlet: CustomTextField!
    @IBOutlet weak var drugAllegryOutlet: CustomTextField!
    @IBOutlet weak var foodAllegryOutlet: CustomTextField!
    var viewModel = PersonalInfoViewModel()
    var error = false
    var gender = ""
    var patientID:Int = 0 {
        didSet {
            print("IDDDD  \(patientID)")
            fetchInfo(patientID: patientID)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        binData()
    }
    
    func binData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                UIApplication.topViewController()?.showLoadingView()
            case false:
                UIApplication.topViewController()?.hideLoadingView()
            }
        }
        
        viewModel.errorMessage.bind { errorMessage in
            if errorMessage != nil {
                AlertsManager.showAlert(withTitle: "ERROR", message: errorMessage?.message, viewController: UIApplication.topViewController())
                self.fetchInfo(patientID: self.patientID)
            }
        }
        
        viewModel.successUpdate.bind { message in
            if message != nil {
                AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: UIApplication.topViewController())
            }
        }
    }
    
    func fetchInfo(patientID:Int){
        viewModel.fetchInfo(patientID:patientID)
        viewModel.patientInfo.bind { [weak self] info in
            DispatchQueue.main.async {
                self?.patientImgV.setImage(with: info?.profilePic ?? "")
                self?.fullNameTF.text           = info?.fullName
                self?.fullNameTF.sendActions(for: .editingChanged)
                self?.mobileNumberTF.text       = info?.mobile
                self?.mobileNumberTF.sendActions(for: .editingChanged)
                self?.birthDateTF.text          = info?.birthdate
                self?.birthDateTF.sendActions(for: .editingChanged)
                self?.nationalIDTF.text         = info?.nationalID
                self?.nationalIDTF.sendActions(for: .editingChanged)
                self?.emailTF.text              = info?.email
                self?.emailTF.sendActions(for: .editingChanged)
                self?.hasCardTF.text            = "\(info?.hasCard ?? false)"
                self?.hasCardTF.sendActions(for: .editingChanged)
                self?.drugTypeOutlet.text       = info?.bloodType
                self?.drugTypeOutlet.sendActions(for: .editingChanged)
                self?.drugAllegryOutlet.text    = info?.drugAllergy
                self?.drugAllegryOutlet.sendActions(for: .editingChanged)
                self?.foodAllegryOutlet.text    = info?.foodAllergy
                self?.foodAllegryOutlet.sendActions(for: .editingChanged)
                if info?.gender == "Male" {
                    self?.gender = "Male"
                    self?.maleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
                    self?.femaleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
                }else if info?.gender == "Female"{
                    self?.gender = "Female"
                    self?.femaleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
                    self?.maleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        let params:[String:String] = [
            "birthdate": birthDateTF.text ?? "",
            "full_name": fullNameTF.text ?? "",
            "gender": gender,
            "national_id": nationalIDTF.text ?? "",
            "mobile": mobileNumberTF.text ?? "",
            "email": emailTF.text ?? "",
            "has_card": "false"
        ]
        if mobileNumberTF.text?.isValidEgyptioanNumber ?? false , nationalIDTF.text?.isValidNationalID ?? false{
            viewModel.updatePatientInfo(patientID: "\(patientID)", patientDetails: params)
        }else{
            AlertsManager.showAlert(withTitle: "ERROR", message: "Enter valid NationalID and mobile number", viewController: UIApplication.topViewController())
        }
        
    }
    
    @IBAction func addCardBtnPressed(_ sender: Any) {
        let vc: AddCardVC = currentStoryboard(.PatientDetails).instantiateViewController(identifier: "AddCardVC")
        vc.patientID = patientID
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(280)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        self.gender = "Male"
        self.maleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        self.femaleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        self.gender = "Female"
        self.femaleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        self.maleBtnOutlet.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
    }
}
