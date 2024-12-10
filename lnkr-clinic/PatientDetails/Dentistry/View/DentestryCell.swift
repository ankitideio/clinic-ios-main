//
//  DentestryCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 12/11/2022.
//

import UIKit

class DentestryCell: UITableViewCell {

    @IBOutlet weak var noDataImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = DentistryViewModel()
    var dentestries:[Dentistry] = []
    var patientID = 0 {
        didSet {
            viewModel.fetcDentistries(userID: patientID)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
        bindData()
        // Initialization code
    }

    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountingTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountingTableViewCell")
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
        
        viewModel.Dentistries.bind { dentestries in
            DispatchQueue.main.async {
                self.dentestries = dentestries ?? []
                self.tableView.reloadData()
            }
        }
        
        viewModel.errorMessage?.bind { error in
            AlertsManager.showAlert(withTitle: "ERROR", message: error?.message, viewController: UIApplication.topViewController())
        }
    }
    
}

extension DentestryCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dentestries.count == 0 {
            noDataImg.isHidden = false
        }else{
            noDataImg.isHidden = true
        }
        return dentestries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountingTableViewCell") as! AccountingTableViewCell
        cell.configureCell(dentestry: dentestries[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
