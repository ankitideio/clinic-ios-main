//
//  FindPatientVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import UIKit

class FindPatientVC: UIViewController {

    @IBOutlet weak var lblConter: UILabel!
    @IBOutlet weak var numberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        numberTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        if numberTF.text?.count != 16 {
            
        }else{
            let vc = currentStoryboard(.PINCode).instantiateViewController(withIdentifier: "PINCodeVC") as! PINCodeVC
            vc.cardNumber = numberTF.text ?? ""
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

extension FindPatientVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = numberTF.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        
        
        if newText.count<=16 { lblConter.text = "\(newText.count)/16" }
        
        
        if newText.count > 16{ return false }
        else{ return true }
        
    }
}
