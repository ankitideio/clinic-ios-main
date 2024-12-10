//
//  ScansCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit
import Presentr
class ScansCell: UITableViewCell ,AddLabProtocol{
    

    @IBOutlet weak var noDataImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var page = 1
    var pageM:Page?
    var scans:[Scan] = []
    var patientID = 0 {
        didSet {
            viewModel.fetcScans(patientID: patientID, page: page)
        }
    }
    
    let viewModel = ScansViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LabsTableCell", bundle: nil), forCellReuseIdentifier: "LabsTableCell")
        bindData()
        // Initialization code
    }
    
    func refresdhLabs() {
        page = 1
        scans = []
        viewModel.fetcScans(patientID: patientID, page: page)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        
        viewModel.scans.bind { scans in
            DispatchQueue.main.async {
                self.scans = scans ?? []
                self.tableView.reloadData()
            }
        }
        
        viewModel.page.bind { page in
            self.pageM = page
        }
    }
    
    
    @IBAction func addScan(_ sender: Any) {
        let vc: AddLabVC = currentStoryboard(.PatientDetails).instantiateViewController(identifier: "AddLabVC")
        vc.isAddScan = true
        vc.patientId = self.patientID
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 0) - 10)), height: .custom(size: Float(400)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true)
    }
}

extension ScansCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scans.count == 0{
            noDataImg.isHidden = false
        }else{
            noDataImg.isHidden = true
        }
        return scans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabsTableCell", for: indexPath) as! LabsTableCell
        cell.configurCell(scan: scans[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = scans.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false {
            page += 1
            viewModel.fetcScans(patientID: patientID, page: page)
        }
    }
    
}
