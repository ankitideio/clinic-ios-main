//
//  AddVisitViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 12/11/2022.
//

import UIKit
import DropDown

protocol AddVisitProtocol {
    func addVisitRo(calender:Calender)
}

class AddVisitViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var patientNameTxtField: UITextField!
    @IBOutlet weak var visitStatusLbl: UILabel!
    @IBOutlet weak var visitStatusTxtField: UITextField!
    @IBOutlet weak var visitTypeLbl: UILabel!
    @IBOutlet weak var visitTypeTxtField: UITextField!
    @IBOutlet weak var pickTimeTxtField: UITextField!
    @IBOutlet weak var patientNameDropDownContainer: CustomOutlineView!
    @IBOutlet weak var visitStatusDropDownContainer: CustomOutlineView!
    @IBOutlet weak var visitTypeDropDownContainer: CustomOutlineView!
    @IBOutlet weak var pickTimeLbl: UILabel!
    @IBOutlet weak var timePickerOutlet: UIDatePicker!
    
    
    let patientNameDropDown     = DropDown()
    let visitStatusDropDown     = DropDown()
    let visitTypeDropDown       = DropDown()
    
    var names:[PatientNames]    = []
    let visitStatusArray        = ["Confirmed" , "Cancelled" , "No Show" , "Rescheduled"]
    let visitTypeArray          = ["first visit" , "repeat visit"]
    
    let viewModel               = CalenderViewModel()
    
    
    var patientID               = 0
    var selectedDate            = ""
    var selectedAppointmentDate = ""
    var delegate:AddVisitProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 10
        setUpDropDowns()
        
        viewModel.getPatientNames(dentID: "\(General.getUserID())")
        bindData()
        
        timePickerOutlet.addTarget(self, action: #selector(handleDatePicker), for: UIControl.Event.valueChanged)
    }
    
    func setUpDropDowns(){
        visitStatusDropDown.anchorView = visitStatusDropDownContainer
        visitStatusDropDown.dataSource = visitStatusArray
        
        visitTypeDropDown.anchorView   = visitTypeDropDownContainer
        visitTypeDropDown.dataSource   = visitTypeArray
        
        visitStatusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.visitStatusTxtField.text = visitStatusArray[index]
        }
        
        visitTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.visitTypeTxtField.text = visitTypeArray[index]
            
        }
    }
    
    @objc func handleDatePicker() {
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: timePickerOutlet.date)
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
            AlertsManager.showAlert(withTitle: "Error", message: "", viewController: self)
        }
        
        viewModel.error.bind { isError in
            if isError == false {
                self.dismiss(animated: true)
            }
        }
        
        viewModel.sucessMessage.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true)
            }
        }
        
        viewModel.names.bind { namesArr in
            DispatchQueue.main.async {
                self.names = namesArr ?? []
            }
        }
    }
    
    @IBAction func visitTypeBttnPressed(_ sender: Any) {
        visitTypeDropDown.show()
    }
    
    @IBAction func submitBttn(_ sender: Any) {
        viewModel.AddVisit(patientID: patientID, title: patientNameTxtField.text ?? "" , type: "visit", visit_status: visitStatusTxtField.text ?? "" , visit_type: visitTypeTxtField.text?.replacingOccurrences(of: " ", with: "_") ?? "", start: selectedAppointmentDate, end: selectedAppointmentDate, cost: "")
    }
    
    @IBAction func cancelBttn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func visitStatusBttnPressed(_ sender: Any) {
        visitStatusDropDown.show()
    }
    
    @IBAction func PatientNameBttnPressed(_ sender: Any) {
        var PatientNameArray:[String]                    = []
        PatientNameArray = names.map(\.full_name!)
        patientNameDropDown.dataSource                   = PatientNameArray
        patientNameDropDown.anchorView                   = patientNameDropDownContainer
        patientNameDropDown.bottomOffset                 = CGPoint(x: 0.0, y: patientNameDropDownContainer.frame.size.height)
        patientNameDropDown.direction                    = .bottom
        patientNameDropDown.show()
        patientNameDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            self?.patientNameTxtField.text = item
            self?.patientID = self?.names[index].id ?? 0
            
        }
    }
}
