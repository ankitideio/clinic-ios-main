//
//  PatientViewController.swift
//  LnkrClinic
//
//  Created by Zaki on 06/11/2022.
//

import UIKit
class PatientViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var noDataVw: UIView!
    @IBOutlet weak var noDataStackVw: UIStackView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var patientView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PatientsViewModel()
    var patients:[Patient] = []
    var filtered           = [Patient]()
    var isFitering         = false
    var page = 1
    var pageM:Page?
    var searchViewModel = PatientVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        searchTF.delegate    = self
        tableView.register(UINib(nibName: "PatientsTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientCell")
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
//        patientView.layer.cornerRadius = 20
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        page = 1
        viewModel.fetchPatients(userID: General.getUserID(), page: page)
        bindData()
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
        
        viewModel.page.bind { page in
            self.pageM = page
        }
        
        viewModel.patients.bind { patients in
            DispatchQueue.main.async {
                self.patients.append(contentsOf: patients ?? [])
                self.tableView.reloadData()
            }
        }
        
        
    }
    @IBAction func actionScanner(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScannerVC") as! ScannerViewController
        vc.callBack = { (cardNo) in

//            self.searchTF.text = cardNo
//            self.isFitering = true
//            self.filtered = self.patients.filter {$0.cardNumber?.range(of: cardNo, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
//            self.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionAddPatient(_ sender: UIButton) {
        let  AddPatientVC = currentStoryboard(.AddPatient).instantiateViewController(identifier: "AddPatientsVC") as! AddPatientsVC
        self.navigationController?.pushViewController(AddPatientVC, animated: true)
    }
    
}

extension PatientViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell") as! PatientsTableViewCell
        if isFitering {
            cell.configureCell(patient: filtered[indexPath.row])
        }else{
            cell.configureCell(patient: patients[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFitering {
            if filtered.count == 0 {
                self.noDataVw.isHidden = false
            }else{
                self.noDataVw.isHidden = true
            }
            return filtered.count
        }
        if patients.count == 0 {
            self.noDataVw.isHidden = false
        }else{ 
            self.noDataVw.isHidden = true
        }
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = currentStoryboard(.PatientDetails).instantiateViewController(withIdentifier: "PatientDetailsVC") as! PatientDetailsVC
//        print("patient is is: \(patients[indexPath.row].id)")
//        vc.patientID = patients[indexPath.row].id
//        self.navigationController?.pushViewController(vc, animated: true)
                let vc = currentStoryboard(.patientInfo).instantiateViewController(withIdentifier: "PatientInfoVC") as! PatientInfoVC
//                vc.patientID = patients[indexPath.row].id ?? 0
        if isFitering == true{
            Store.patientId = filtered[indexPath.row].id ?? 0
            Store.patientName = filtered[indexPath.row].fullName ?? ""
        }else{
            Store.patientId = patients[indexPath.row].id ?? 0
            Store.patientName = patients[indexPath.row].fullName ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = patients.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false{
            page += 1
            viewModel.fetchPatients(userID: General.getUserID(), page: page)
        }
    }
}

extension PatientViewController:UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = searchTF.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        
        
        if newText.count == 0 {
            isFitering = false
            Store.isSearch = false
            page = 1
            viewModel.fetchPatients(userID: General.getUserID(), page: page)
            bindData()
        }else{
            isFitering = true
            Store.isSearch = true
            searchViewModel.searchPatientApi(search: newText) { data in
                self.filtered.removeAll()
                self.filtered.append(contentsOf: data ?? [])
                self.tableView.reloadData()
                
            }


        }
        return true
    }
}
