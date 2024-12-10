//
//  LabsCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit
import Presentr
class LabsCell: UITableViewCell,AddLabProtocol {
   
    

    @IBOutlet weak var noLabsOmg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = LabsViewModel()
    var page = 1
    var pageM:Page?
    var labs:[Lab] = []
    var patientID = 0 {
        didSet {
            page = 1
            labs = []
            viewModel.fetcLabs(patientID: patientID, page: page)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LabsTableCell", bundle: nil), forCellReuseIdentifier: "LabsTableCell")
        bindData()
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
        
        viewModel.page.bind { page in
            self.pageM = page
        }
        
        viewModel.labs.bind { labs in
            DispatchQueue.main.async {
                self.labs.append(contentsOf: labs ?? [])
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func refresdhLabs() {
        page = 1
        labs = []
        viewModel.fetcLabs(patientID: patientID, page: page)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addLab(_ sender: Any) {
        let vc: AddLabVC = currentStoryboard(.PatientDetails).instantiateViewController(identifier: "AddLabVC")
        vc.patientId = self.patientID
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 0) - 10)), height: .custom(size: Float(400)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true)
        //customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}

extension LabsCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if labs.count == 0 {
            noLabsOmg.isHidden = false
        }else{
            noLabsOmg.isHidden = true
        }
        return labs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabsTableCell", for: indexPath) as! LabsTableCell
        cell.configurCell(lab: labs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = labs.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false{
            page += 1
            viewModel.fetcLabs(patientID: patientID, page: page)
        }
    }
    
}
