//
//  PINCodeVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13/11/2022.
//

import UIKit

class PINCodeVC: UIViewController {
    
    var pinCodeText = "" {
        didSet {
            restrictTF()
        }
    }
    
    @IBOutlet weak var pinTF: UITextField!
    var cardNumber = ""
    var patientID = 0
    let viewModel = PINCodeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func restrictTF(){
        if pinCodeText.count == 4 {
            print("-----")
            print(pinCodeText)
            pinTF.text = pinCodeText
            viewModel.findPatient(cardNumber: cardNumber, pinCode: pinCodeText)
        }else if pinCodeText.count <= 4{
            pinTF.text = pinCodeText
        }
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
        
        viewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: error.message, viewController: self)
        }
        
        viewModel.patintID.bind { id in
            guard let id = id else { return }
            self.navigateToPatient(patientID: id)
        }
    }
    
    func navigateToPatient(patientID:Int){
        let vc = currentStoryboard(.PatientDetails).instantiateViewController(withIdentifier: "PatientDetailsVC") as! PatientDetailsVC
        vc.patientID     = patientID
        vc.isFromPINCode = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func numberClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            pinCodeText = pinCodeText.appending("0")
        case 1:
            pinCodeText = pinCodeText.appending("1")
        case 2:
            pinCodeText = pinCodeText.appending("2")
        case 3:
            pinCodeText = pinCodeText.appending("3")
        case 4:
            pinCodeText = pinCodeText.appending("4")
        case 5:
            pinCodeText = pinCodeText.appending("5")
        case 6:
            pinCodeText = pinCodeText.appending("6")
        case 7:
            pinCodeText = pinCodeText.appending("7")
        case 8:
            pinCodeText = pinCodeText.appending("8")
        case 9:
            pinCodeText = pinCodeText.appending("9")
        default:
            print("nothing")
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

