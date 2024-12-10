//
//  LoginViewController.swift
//  LnkrClinic
//
//  Created by Zaki on 05/11/2022.
//

import UIKit
import SideMenu

class LoginViewController: UIViewController {
    
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var btnRememberMeOutlet: UIButton!
    @IBOutlet weak var emailTxtField: CustomTextField!
    @IBOutlet weak var passwordTxtField: CustomTextField!
    @IBOutlet weak var loginBttn: UIButton!
    
    private let loginViewModel = LoginViewModel()
    private var GetLoginDet : LoginModelResponse?
    var showPass     = false
    var isRememberMe = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpViewModel()
        bindData()
        roundedBttnWithShadow(Bttn: loginBttn)
        if General.getEmail() != "" {
            emailTxtField.text = General.getEmail()
            self.emailTxtField.sendActions(for: .editingChanged)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func bindData(){
        loginViewModel.success.bind { isSuccess in
            if isSuccess {
                General.openHomeVC()
                //self.dismiss(animated: true)
                print("success")
            }else{
                print("failure")
            }
        }
        
        loginViewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        loginViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: error.message, viewController: self)
        }
    }
    
    @IBAction func rememberMe(_ sender: Any) {
        isRememberMe = !isRememberMe
        if isRememberMe {
            btnRememberMeOutlet.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }else{
            btnRememberMeOutlet.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        }
    }

    func roundedBttnWithShadow(Bttn: UIButton) {
        Bttn.layer.cornerRadius = Bttn.frame.size.height/5
        Bttn.layer.shadowColor = UIColor.black.cgColor
        Bttn.layer.shadowRadius = 2
        Bttn.layer.shadowOpacity = 0.5
        Bttn.layer.shadowOffset = CGSize(width: 0.0 , height: 2.0)
    }
    
    
    
    @IBAction func loginBttnPressed(_ sender: Any) {
      //  if emailTxtField.text?.isValidEmailAddress ?? false {
            loginViewModel.login(email: emailTxtField.text ?? "", password: passwordTxtField.text ?? "")
//        }else{
//            emailTxtField.showError()
//            AlertsManager.showAlert(withTitle: "Invalid Email Address", message: "Please enter a valid email address", viewController: self)
//        }
     
    }
    
    @IBAction func showPassword(_ sender: Any) {
        showPass = !showPass
        if showPass {
            self.eyeBtn.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
            self.passwordTxtField.isSecureTextEntry = false
        }else{
            self.eyeBtn.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
            self.passwordTxtField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        let storyboard = currentStoryboard(.Login)
        let vc = storyboard.instantiateViewController(identifier: "RegisterVC")
        self.present(vc, animated: true)
    }
}
