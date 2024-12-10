//
//  PricingCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/11/2022.
//

import UIKit

class PricingCell: UICollectionViewCell {

    @IBOutlet weak var examinationTF: CustomTextField!
    @IBOutlet weak var followUpTF: CustomTextField!
    
    @IBOutlet weak var consulatationTf: CustomTextField!
    @IBOutlet weak var emergencyTF: CustomTextField!
    @IBOutlet weak var othersTF: CustomTextField!
    
    let viewModel = PhysicanViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        bindData()
        setDataInView()
        // Initialization code
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
                General.setFirstvisit(firistVisit: Int(self.examinationTF.text ?? "0"))
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: UIApplication.topViewController())
        }
    }
    
    func setDataInView(){
//        examinationTF.text = "\(General.getFirstvisit())"
//        self.examinationTF.sendActions(for: .editingChanged)
//        followUpTF.text = "\(General.getRepeatVisit())"
//        self.followUpTF.sendActions(for: .editingChanged)
//        consulatationTf.text = "\(General.getConsultation())"
//        self.consulatationTf.sendActions(for: .editingChanged)
    }

    @IBAction func updateButtonPressed(_ sender: Any) {
        if !examinationTF.text!.isEmpty && !(consulatationTf.text?.isEmpty ?? false) && !(followUpTF.text?.isEmpty ?? false) {
            let params:[String:Any] = [
                "pricing": [
                    "others": 0,
                    "emergency": Int(emergencyTF.text ?? "0") ?? 0,
                    "examination": Int(examinationTF.text ?? "0") ?? 0,
                    "consultation": Int(consulatationTf.text ?? "0") ?? 0,
                    "follow_up": Int(followUpTF.text ?? "0") ?? 0
                ]
            ]
            
            viewModel.updateDentistPricing(params: params)
        }else{
            AlertsManager.showAlert(withTitle: "ERROR", message: "Please fill in all fields", viewController: UIApplication.topViewController())
        }
    }
}
