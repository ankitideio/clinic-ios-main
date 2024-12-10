//
//  RequesUpdateCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit
import Presentr
class RequesUpdateCell: UICollectionViewCell , AddRequestProtocol{
 
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = RequestsViewModel()
    var requests:[RequestsData] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
        viewModel.getRequests(dentistID: "\(General.getUserID())")
        bindData()
        // Initialization code
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RequestsTableCell", bundle: nil), forCellReuseIdentifier: "RequestsTableCell")
    }
    
    func addRequest() {
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.requests = []
            self.viewModel.getRequests(dentistID: "\(General.getUserID())")
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
        
        viewModel.requests.bind { requests in
            guard let requests = requests else { return }
            self.requests = requests.data ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: message.message, viewController: UIApplication.topViewController())
        }
    }
    
    @IBAction func addRequestPressed(_ sender: Any) {
        let vc: AddRequestVC = currentStoryboard(.Setting).instantiateViewController(identifier: "AddRequestVC")
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(350)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    

}

extension RequesUpdateCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if requests.isEmpty {
            imgNoData.isHidden = false
        }else{
            imgNoData.isHidden = true
        }
        
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsTableCell", for: indexPath) as! RequestsTableCell
        cell.configureCell(request: requests[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}
