//
//  SyndicateCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit

class SyndicateCell: UICollectionViewCell {

    @IBOutlet weak var syndicateIDTF: CustomTextField!
    @IBOutlet weak var syndicateRegistrationTF: CustomTextField!
    @IBOutlet weak var practicalLicence: CustomTextField!
    @IBOutlet weak var licenceDateTF: CustomTextField!
    
    var viewModel = SyndicateViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        bindData()
        // Initialization code
    }
    
    func bindData(){
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: UIApplication.topViewController())
        }
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message.message, viewController: UIApplication.topViewController())
        }
    }

    @IBAction func uodateSyndicate(_ sender: Any) {
        let params:[String:String] = [
            "syndicate_id": syndicateIDTF.text ?? "",
            "syndicate_registration_date": syndicateRegistrationTF.text ?? "",
            "practitioner_license_no": practicalLicence.text ?? "",
            "practitioner_license_date": licenceDateTF.text ?? ""
        ]
        
        if syndicateIDTF.text?.isEmpty ?? false || syndicateRegistrationTF.text?.isEmpty ?? false || practicalLicence.text?.isEmpty ?? false || licenceDateTF.text?.isEmpty ?? false {
            AlertsManager.showAlert(withTitle: "ERROR", message: "Please fill in all fields", viewController: UIApplication.topViewController())
        }else{
            viewModel.addSyndicateInfo(params: params)
        }
    }
    
}
