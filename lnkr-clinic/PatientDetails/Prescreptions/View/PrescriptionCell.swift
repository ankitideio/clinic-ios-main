//
//  PrescriptionCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13/11/2022.
//

import UIKit

class PrescriptionCell: UITableViewCell {

    @IBOutlet weak var noDataImgV: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = PrescriptionViewModel()
    var prescriptions:[Prescription] = []
    var pageM:Page?
    var page = 1
    var patientID = 0 {
        didSet {
            page = 1
            prescriptions = []
            viewModel.fetcPrescriptions(patientID: patientID, page: page)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTV()
        binDatainView()
        // Initialization code
    }
    
    func binDatainView(){
        
        viewModel.page.bind { page in
            self.pageM = page
        }
        
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                UIApplication.topViewController()?.showLoadingView()
            case false:
                UIApplication.topViewController()?.hideLoadingView()
            }
        }
        
        viewModel.prescriptions.bind { prescriptions in
            DispatchQueue.main.async {
                self.prescriptions.append(contentsOf: prescriptions ?? [])
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    
    func setUpTV(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PrescriptionTableCell", bundle: nil), forCellReuseIdentifier: "PrescriptionTableCell")
    }
    
    
    @IBAction func addPrescription(_ sender: Any) {
        let vc: AddPrescriptionVC = currentStoryboard(.ADDPrescription).instantiateViewController(identifier: "AddPrescriptionVC")
        vc.patientID = self.patientID
        UIApplication.topViewController()?.present(vc, animated: true)
    }
}

extension PrescriptionCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prescriptions.count == 0 {
            noDataImgV.isHidden = false
        }else{
            noDataImgV.isHidden = true
        }
        
        return prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrescriptionTableCell", for: indexPath) as! PrescriptionTableCell
        cell.configureCell(prescription: prescriptions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: PrescriptionsClinicViewController = currentStoryboard(.PrescriptionsClinic).instantiateViewController(identifier: "PrescriptionsClinicViewController")
        vc.presUuid = prescriptions[indexPath.row].uuid ?? ""
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = prescriptions.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false{
            page += 1
            viewModel.fetcPrescriptions(patientID: patientID, page: page)
        }
    }
    
}
