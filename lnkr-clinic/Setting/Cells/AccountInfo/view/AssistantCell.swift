//
//  AssistantCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit
import Presentr
class AssistantCell: UICollectionViewCell {
    
    @IBOutlet weak var nationalIDTF: CustomTextField!
    @IBOutlet weak var mobileNumberTF: CustomTextField!
    
    let viewModel = AccountInfoViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        bindData()
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
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: UIApplication.topViewController())
        }
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: message.message, viewController: UIApplication.topViewController())
        }
    }
    
    @IBAction func updateDentist(_ sender: Any) {
        let params = [
            "mobile": mobileNumberTF.text ?? "",
            "national_id": nationalIDTF.text ?? ""
        ]
        viewModel.updateAccountInfo(params: params)
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let vc: ResetPasswordVC = currentStoryboard(.Setting).instantiateViewController(identifier: "ResetPasswordVC")
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(350)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}

