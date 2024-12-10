//
//  PatientOtpVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class PatientOtpVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var txtFldFirst: UITextField!
    @IBOutlet weak var txtFldSecond: UITextField!
    @IBOutlet weak var txtFldFourth: UITextField!
    @IBOutlet weak var txtFldThird: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
    }
    
    
}
