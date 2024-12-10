//
//  AddReport.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import UIKit

protocol AddReportProtocol {
    func addReportRo(report:Report)
}

class AddReport: UIViewController {

    @IBOutlet weak var bodyTF: CustomTextField!
    @IBOutlet weak var titleTF: CustomTextField!
    let viewModel = ReportsViewModel()
    var patientID = 0
    var delegate:AddReportProtocol?
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
        
        viewModel.errorMessage.bind { message in
            AlertsManager.showAlert(withTitle: "Error", message: message?.message, viewController: self)
        }
        
        viewModel.error.bind { isError in
            if isError == false {
                self.dismiss(animated: true)
            }
        }
        
        viewModel.addedReport.bind { report in
            guard let report = report else {return}
            self.delegate?.addReportRo(report: report)
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        viewModel.addReport(patientID: "\(patientID)", title: titleTF.text ?? "", body: bodyTF.text ?? "")
    }
}
