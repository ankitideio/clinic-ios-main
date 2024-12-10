//
//  ClinicCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/11/2022.
//

import UIKit
import Presentr
class ClinicCell: UICollectionViewCell , AddWorkingDayProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fullnameTF: CustomTextField!
    @IBOutlet weak var mobileNumberTF: CustomTextField!
    @IBOutlet weak var bodyTF: CustomTextField!
    @IBOutlet weak var regestrationIDTf: CustomTextField!
    @IBOutlet weak var specialityTF: CustomTextField!
    @IBOutlet weak var cityTF: CustomTextField!
    
    
    var viewModel = ClinicViewModel()
    var workingDays:[WorkingDaysHourr] = []
    var workingDayss:[WorkingDaysHour] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
        viewModel.readClinic(clinicID: General.getClinicID())
        bindData()
        // Initialization code
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
        
        viewModel.details.bind { data in
            guard let data else { return }
            self.setDataInView(data: data)
           // self.workingDays = data.workingDaysHours ?? []
            DispatchQueue.main.async {
                self.fullnameTF.text = data.name
                self.mobileNumberTF.text = data.phoneNum
                self.tableView.reloadData()
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCCESS", message: message, viewController: UIApplication.topViewController())
        }
    }
    
    func setDataInView(data:Cliniccc){
        fullnameTF.text = data.name
        self.fullnameTF.sendActions(for: .editingChanged)
        mobileNumberTF.text = data.phoneNum
        self.mobileNumberTF.sendActions(for: .editingChanged)
        bodyTF.text = data.joinedDate
        self.bodyTF.sendActions(for: .editingChanged)
        bodyTF.text = data.joinedDate
        self.bodyTF.sendActions(for: .editingChanged)
        regestrationIDTf.text = data.registrationID
        self.regestrationIDTf.sendActions(for: .editingChanged)
        specialityTF.text = data.specialities?.first?.specialities
        self.specialityTF.sendActions(for: .editingChanged)
        cityTF.text = data.address?.city
        self.cityTF.sendActions(for: .editingChanged)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WorkingDaysCell", bundle: nil), forCellReuseIdentifier: "WorkingDaysCell")
    }
    
    func addWorkingDay(workingDay: WorkingDaysHourr) {
        self.workingDays.append(workingDay)
        tableView.reloadData()
    }
    
    
    @IBAction func addWorkingDay(_ sender: Any) {
        let vc: AddWorkingDayVC = currentStoryboard(.Setting).instantiateViewController(identifier: "AddWorkingDayVC")
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(270)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    
    @IBAction func addAddressBtnPressed(_ sender: Any) {
        let vc: AddClinicAddressVC = currentStoryboard(.Setting).instantiateViewController(identifier: "AddClinicAddressVC")
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float((UIApplication.topViewController()?.view.bounds.width ?? 200) - 10)), height: .custom(size: Float(320)), center: .center))
        UIApplication.topViewController()?.customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        let params:[String:Any] = [
            "working_days_hours": [
                [
                    "id": "1",
                    "day": "Sunday",
                    "hours": ["13", "12"]
                ]
            ]
        ]
        
        viewModel.updateClinic(clinicID: General.getClinicID(), params: params)
    }
}

extension ClinicCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workingDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingDaysCell", for: indexPath) as! WorkingDaysCell
        cell.configureCell(title: workingDays[indexPath.row].day ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}
