//
//  AddWorkingDayVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import UIKit
import DropDown

protocol AddWorkingDayProtocol {
    func addWorkingDay(workingDay:WorkingDaysHourr)
}
class AddWorkingDayVC: UIViewController {

    @IBOutlet weak var chooswDayOutlet: UIButton!
    
    @IBOutlet weak var hourFromOutlet: UIButton!
    
    @IBOutlet weak var hourToOutlet: UIButton!
    
    @IBOutlet weak var chooseDayContainer: UIView!
    var daysDropDown = DropDown()
    var delegate:AddWorkingDayProtocol?
    
    var viewModel = AddWorkingDaysViewModel()
    var idNum = 0
    let days = ["Sturday","Sunday","Monday","Tuesday","Wednesday","Thrusday","Friday"]
    let hours = ["12","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()

        // Do any additional setup after loading the view.
    }
    
    func bindData(){
        viewModel.success.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "Success", message: message, viewController: self, showingCancelButton: false, showingOkButton: true, cancelHandler: nil, actionTitle: "OK", actionStyle: .default) { _ in
                self.dismiss(animated: true)
            }
        }
        
        viewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertsManager.showAlert(withTitle: "ERROR", message: error.message, viewController: self, showingCancelButton: false, showingOkButton: true, cancelHandler: nil, actionTitle: "OK", actionStyle: .default)
        }
        
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
    }
    
    @IBAction func chooseDayPressed(_ sender: UIButton) {
        daysDropDown.dataSource                   = days
        daysDropDown.anchorView                   = chooseDayContainer
        daysDropDown.bottomOffset                 = CGPoint(x: 0.0, y: chooseDayContainer.frame.size.height)
        daysDropDown.direction                    = .bottom
        daysDropDown.show()
        daysDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func hourFromPressed(_ sender: UIButton) {
        daysDropDown.dataSource                   = hours
        daysDropDown.anchorView                   = sender
        daysDropDown.bottomOffset                 = CGPoint(x: 0.0, y: sender.frame.size.height)
        daysDropDown.direction                    = .bottom
        daysDropDown.show()
        daysDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func hourToPressed(_ sender: UIButton) {
        daysDropDown.dataSource                   = hours
        daysDropDown.anchorView                   = sender
        daysDropDown.bottomOffset                 = CGPoint(x: 0.0, y: sender.frame.size.height)
        daysDropDown.direction                    = .bottom
        daysDropDown.show()
        daysDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
            self?.idNum = index
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if chooswDayOutlet.titleLabel?.text == "Choose Day" || hourToOutlet.titleLabel?.text == "Hour to" || hourFromOutlet.titleLabel?.text == "Hour From" {
            AlertsManager.showAlert(withTitle: "Alert", message: "Please choose from all fields", viewController: self)
        }else {
            guard let from = Int(hourFromOutlet.titleLabel?.text ?? "") else { return }
            guard let to = Int(hourToOutlet.titleLabel?.text ?? "") else { return  }
            
            let params = [
                "working_days_hours": [
                    "Saturday": [
                        [
                            "start_hour": "\(from):00",
                            "end_hour": "\(to):00",
                            "patient_time": 15
                        ]
                    ]
                ]
            ]
            
            viewModel.AddWorkingDay(params: params)
            //var arr:[String] = []
            //arr.append("\(from)")
            //arr.append("\(to)")
            //let workingDay = WorkingDaysHourr(id: "\(self.idNum)", day: chooswDayOutlet.titleLabel?.text ?? "", hours: arr)
            //self.delegate?.addWorkingDay(workingDay: workingDay)
            //self.dismiss(animated: true)
        }
    }
}
