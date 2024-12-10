//
//  VisitsCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13/11/2022.
//

import UIKit

class VisitsCell: UITableViewCell {

    @IBOutlet weak var noViditsImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = VisitsViewModel()
    var page = 0
    var pageM:Page?
    var visits:[VisitModel] = []
    var patientID:Int = 0 {
        didSet {
            self.fetchData(userID: patientID, page: page)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        bindData()
        //Initialization code
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
        
        viewModel.visits.bind { visits in
            DispatchQueue.main.async {
                self.visits = visits ?? []
                self.tableView.reloadData()
            }
        }
        
        viewModel.page.bind { page in
            self.pageM = page
        }
    }
    
    func registerCell(){
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VisitTableCell", bundle: nil), forCellReuseIdentifier: "VisitTableCell")
    }
    
    func fetchData(userID:Int,page:Int){
        viewModel.fetcVisits(userID: userID, page: page)
    }
    
}

extension VisitsCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if visits.count == 0 {
            noViditsImg.isHidden = false
        }else{
            noViditsImg.isHidden = true
        }
        return visits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitTableCell", for: indexPath) as! VisitTableCell
        cell.configureCell(visit: visits[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = visits.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && page <= pageM?.pages ?? 1{
            page += 1
            viewModel.fetcVisits(userID: patientID, page:   page)
        }
    }
}
