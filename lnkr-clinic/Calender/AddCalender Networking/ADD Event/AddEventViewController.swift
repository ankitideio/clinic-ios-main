//
//  AddEventViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 12/11/2022.
//

import UIKit

protocol AddEventProtocol {
    func addEventRo(calender:Calender)
}
class AddEventViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var eventTitleTxtField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let viewModel = CalenderViewModel()
    var patientID = 0
    var delegate:AddEventProtocol?
    var selectedDate            = ""
    var selectedAppointmentDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 10
        bindData()
        timePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControl.Event.valueChanged)
    }
    
    @objc func handleDatePicker() {
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
        let hour = components.hour!
        let minute = components.minute!
        selectedAppointmentDate = "\(selectedDate)T\(hour):\(minute):00.000Z"
        print(selectedAppointmentDate)
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
        
        viewModel.addedEvent.bind { event in
            guard let event = event else {return}
            self.delegate?.addEventRo(calender: event)
        }
    }
    
    
    @IBAction func submitBttnPressed(_ sender: Any) {
        if eventTitleTxtField.text?.isEmpty ?? false {
            AlertsManager.showAlert(withTitle: "ALert", message: "Please type an event title", viewController: self)
        }else{
            viewModel.AddEvent(patientID: 2054 , title: eventTitleTxtField.text ?? "", type: "event", visit_status: "" , visit_type: "", start: selectedAppointmentDate, end: selectedAppointmentDate, cost: "")
        }
    }
    
    
    @IBAction func cancelBttnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
