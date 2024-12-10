//
//  PrescriptionsClinicViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 14/11/2022.
//

import UIKit

class PrescriptionsClinicViewController: UIViewController {
    
    
    
    @IBOutlet weak var telephoneLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var clinicLbl: UILabel!
    @IBOutlet weak var drugsTableView: UITableView!
    @IBOutlet weak var scansLbl: UILabel!
    @IBOutlet weak var labsLbl: UILabel!
    @IBOutlet weak var medicalSupplies: UILabel!
    @IBOutlet weak var diagnosis: UILabel!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var prescriptionDate: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var arDentistName: UILabel!
    @IBOutlet weak var enDentistName: UILabel!
    var viewModel = PrescriptionDetailsViewModel()
    var presUuid = ""
    var drugs:[DrugModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetccDetails(uuid: presUuid)
        bindData()
        setUpGrugsTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func setUpGrugsTable(){
        drugsTableView.delegate = self
        drugsTableView.dataSource = self
        drugsTableView.register(UINib(nibName: "drugsCell", bundle: nil), forCellReuseIdentifier: "drugsCell")
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
        viewModel.prescription.bind { [weak self] details in
            DispatchQueue.main.async {
                self?.telephoneLbl.text     = details?.data?.clinic?.phoneNum
                self?.bodyLbl.text          = details?.data?.clinic?.address?.city
                self?.clinicLbl.text        = details?.data?.clinic?.name
                self?.scansLbl.text         = details?.data?.notes?.scans
                self?.labsLbl.text          = details?.data?.notes?.labs
                self?.medicalSupplies.text  = details?.data?.notes?.medicalSupplies
                self?.diagnosis.text        = details?.data?.diseases?[0].label
                self?.patientAge.text       = details?.data?.patient?.birthdate
                self?.prescriptionDate.text = details?.data?.createdDate
                self?.patientName.text      = details?.data?.patient?.fullName
                self?.arDentistName.text    = details?.data?.dentist?.arabic_name
                self?.enDentistName.text    = details?.data?.dentist?.full_name
                self?.drugs                 = details?.data?.drug
                DispatchQueue.main.async {
                    self?.drugsTableView.reloadData()
                }
            }
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PrescriptionsClinicViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drugsCell", for: indexPath) as! drugsCell
        cell.configureCell(drug: (drugs?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
