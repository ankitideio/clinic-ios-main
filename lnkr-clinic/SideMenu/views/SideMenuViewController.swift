//
//  SideMenuViewController.swift
//  LnkrClinic
//
//  Created by Zaki on 06/11/2022.
//

import UIKit
class SideMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AccountingBttnPressed(_ sender: Any) {
        let vc = currentStoryboard(.Accounting).instantiateViewController(withIdentifier: "AccVC") as! AccountingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func insuranceBttnPressed(_ sender: Any) {
        let vc = currentStoryboard(.Insurence).instantiateViewController(withIdentifier: "InsurenceVC") as! InsurenceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func contractsBttnPressed(_ sender: Any) {
        let vc = currentStoryboard(.Contracts).instantiateViewController(withIdentifier: "ContractsVC") as! ContractsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingBttnPressed(_ sender: Any) {
        let vc = currentStoryboard(.Setting).instantiateViewController(withIdentifier: "Setting") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutBttnPressed(_ sender: Any) {
        
        AlertsManager.showAlert(withTitle: "Alert!", message: "Are you sure you want to logout", viewController: self, showingCancelButton: true, showingOkButton: true, cancelHandler: nil, actionTitle: "logOut", actionStyle: .default) { _ in
            General.setLoginState(isLogin: false)
            self.dismiss(animated: true) {
                General.openLoginVC()
            }
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
