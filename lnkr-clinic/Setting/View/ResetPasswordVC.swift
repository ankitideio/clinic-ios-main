//
//  ResetPasswordVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 05/12/2022.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var confirmPasswordTFOutlet: CustomTextField!
    @IBOutlet weak var newPasswordTFOutlet: CustomTextField!
    @IBOutlet weak var oldPasswordTFOutlet: CustomTextField!
    var showOld = false
    var showNew = false
    var showConfirm = false
    let viewModel = PhysicanViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func bindData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true)
            }
        }
    }
    
    
    @IBAction func showHidePassword(_ sender: UIButton) {
        switch sender.tag {
        case 4:
            showOld = !showOld
            if showOld {
                sender.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
                self.oldPasswordTFOutlet.isSecureTextEntry = false
            }else{
                sender.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
                oldPasswordTFOutlet.isSecureTextEntry = true
            }
        case 2:
            showNew = !showNew
            if showNew {
                sender.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
                self.newPasswordTFOutlet.isSecureTextEntry = false
            }else{
                sender.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
                newPasswordTFOutlet.isSecureTextEntry = true
            }
        case 3:
            showConfirm = !showConfirm
            if showConfirm {
                sender.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
                self.confirmPasswordTFOutlet.isSecureTextEntry = false
            }else{
                sender.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
                confirmPasswordTFOutlet.isSecureTextEntry = true
            }
            
        default:
            print("")
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if oldPasswordTFOutlet.text?.isEmpty ?? true || newPasswordTFOutlet.text?.isEmpty ?? true || confirmPasswordTFOutlet.text?.isEmpty ?? true {
            AlertsManager.showAlert(withTitle: "Error", message: "Please complete all fields", viewController: self)
        }else if confirmPasswordTFOutlet.text != newPasswordTFOutlet.text {
            AlertsManager.showAlert(withTitle: "Error", message: "New password not confirmed", viewController: self)
        }else{
            viewModel.updatePassword(oldPassword: oldPasswordTFOutlet.text ?? "", newPassword: newPasswordTFOutlet.text ?? "")
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
