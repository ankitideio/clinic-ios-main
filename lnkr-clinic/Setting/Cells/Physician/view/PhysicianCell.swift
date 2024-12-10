//
//  PhysicianCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/11/2022.
//

import UIKit
import Presentr
class PhysicianCell: UICollectionViewCell {

    @IBOutlet weak var fullNameTF: CustomTextField!
    @IBOutlet weak var mobileNumberTF: CustomTextField!
    @IBOutlet weak var nationalIDTF: CustomTextField!
    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet weak var syndicateIDTF: CustomTextField!
    @IBOutlet weak var qualificationsTF: CustomTextField!
    
    
    let viewModel = PhysicanViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel.getDentistInfo()
        setDataInView()
        bindData()
    }
    
    func bindData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                UIApplication.topViewController()?.showLoadingView()
            case false:
                UIApplication.topViewController()?.hideLoadingView()
            }
        }
        
        viewModel.sucess.bind { isSucces in
            if isSucces {
                General.setUserFullNAme(userFullName: self.fullNameTF.text)
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: UIApplication.topViewController())
        }
        
        viewModel.dentistInfo.bind { dentistInfo in
            guard let info = dentistInfo else { return }
            DispatchQueue.main.async {
                self.fullNameTF.text = info.data?.fullName
                self.fullNameTF.sendActions(for: .editingChanged)
                self.qualificationsTF.text = info.data?.city
                self.qualificationsTF.sendActions(for: .editingChanged)
            }
        }
    }
    
    func setDataInView(){
        fullNameTF.text = General.getUserFullNAme()
        self.fullNameTF.sendActions(for: .editingChanged)
        mobileNumberTF.text = General.getDentistMobile()
        self.mobileNumberTF.sendActions(for: .editingChanged)
        nationalIDTF.text = General.getNationalID()
        self.nationalIDTF.sendActions(for: .editingChanged)
        emailTF.text = General.getEmail()
        self.emailTF.sendActions(for: .editingChanged)
        syndicateIDTF.text = General.getSyndicateID()
        self.syndicateIDTF.sendActions(for: .editingChanged)
        qualificationsTF.text = General.getDentistQualifications()
        self.qualificationsTF.sendActions(for: .editingChanged)
    }
    
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        if !fullNameTF.text!.isEmpty && !(mobileNumberTF.text?.isEmpty ?? false) && !(nationalIDTF.text?.isEmpty ?? false) && !(emailTF.text?.isEmpty ?? false) && !(syndicateIDTF.text?.isEmpty ?? false) && !(qualificationsTF.text?.isEmpty ?? false) {
            let params:[String:Any] = [
                "full_name": fullNameTF.text ?? "",
                "mobile": mobileNumberTF.text ?? "",
                "national_id": nationalIDTF.text ?? "",
                "pricing": [
                    "others": 0,
                    "fast_visit": 400,
                    "first_visit": General.getFirstvisit(),
                    "consultation": General.getConsultation(),
                    "repeat_visit": General.getRepeatVisit()
                ]
            ]
            
            viewModel.updateDentist(dentistID: "\(General.getDentistUuid())", details: params)
        }else{
            AlertsManager.showAlert(withTitle: "ERROR", message: "Please fill in all fields", viewController: UIApplication.topViewController())
        }
    }
    
    @IBAction func resetPassowrdButtonPressed(_ sender: Any) {

        let vc: ResetPasswordVC = currentStoryboard(.Setting).instantiateViewController(identifier: "ResetPasswordVC")
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(350)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}
