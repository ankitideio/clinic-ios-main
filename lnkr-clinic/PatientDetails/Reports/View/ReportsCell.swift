//
//  ReportsCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit
import Presentr
class ReportsCell: UITableViewCell, AddReportProtocol {
    

    @IBOutlet weak var noDataImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ReportsViewModel()
    var pageM:Page?
    var page = 1
    var reports:[Report] = []
    var patirntID = 0 {
        didSet{
            page = 1
            reports = []
            viewModel.fetcReports(patientID: patirntID, page: page)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReportTableCell", bundle: nil), forCellReuseIdentifier: "ReportTableCell")
        bindData()
        // Initialization code
    }
    
    func bindData(){
        viewModel.page.bind { page in
            self.pageM = page
        }
        
        viewModel.reports.bind { reports in
            DispatchQueue.main.async {
                self.reports.append(contentsOf: reports ?? [])
                self.tableView.reloadData()
            }
        }
        
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                UIApplication.topViewController()?.showLoadingView()
            case false:
                UIApplication.topViewController()?.hideLoadingView()
            }
        }
    }
    
    func addReportRo(report: Report) {
        self.reports = []
        page = 1
        viewModel.fetcReports(patientID: patirntID, page: page)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addReport(_ sender: Any) {
        let vc: AddReport = currentStoryboard(.PatientDetails).instantiateViewController(identifier: "AddReport")
        vc.patientID = self.patirntID
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 0) - 10)), height: .custom(size: Float(350)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true)
    }
}
extension ReportsCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reports.count == 0{
            noDataImg.isHidden = false
        }else{
            noDataImg.isHidden = true
        }
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableCell", for: indexPath) as! ReportTableCell
        cell.configureCell(report: reports[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = reports.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false{
            page += 1
            viewModel.fetcReports(patientID: patirntID, page: page)
        }
    }
}
