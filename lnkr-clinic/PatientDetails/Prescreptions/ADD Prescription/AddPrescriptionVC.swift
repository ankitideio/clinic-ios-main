//
//  AddPrescriptionVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import UIKit
import Presentr
import DropDown
import SearchTextField

struct item {
    var title:String?
    var id:Int?
    var name:String?
}
class AddPrescriptionVC: UIViewController , addDrugProtocol {
   
    @IBOutlet weak var deseaseTF: SearchTextField!
    @IBOutlet weak var drugsTableView: UITableView!
    @IBOutlet weak var insurenceBtn: UIButton!
    
    
    var drugs:[Drug]            = []
    var drugsDict:[[String:String?]]  = []
    var insurencesDropDown      = DropDown()
    var viewModel               = PrescriptionViewModel()
    var insurences:[Insurence]  = []
    var desease:[Insurence]     = []
    var dect:[String:Int]       = [:]
    var deseaseNames:[String]   = []
    var deseaseIDs:[Int]        = []
    var insurenceID             = 0
    var patientID               = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setUpTableView()
        //viewModel.addPres()
    }
    
    func setUpTableView(){
        drugsTableView.register(UINib(nibName: "WorkingDaysCell", bundle: nil), forCellReuseIdentifier: "WorkingDaysCell")
        drugsTableView.delegate = self
        drugsTableView.dataSource = self
        
    }
    
    func bindData(){
        viewModel.fetchInsurences()
        viewModel.fetchDesease()
        viewModel.insurences.bind { [weak self] insurencse in
            self?.insurences = insurencse ?? []
        }
        
        viewModel.desease.bind { desease in
            self.desease = desease ?? []
            for i in self.desease {
                guard let title = i.label else { return }
                self.dect[title] = i.value
                self.deseaseNames.append(title)
            }
            print(self.deseaseNames)
            self.setupDeseaseTF()
        }
    }
    
    func setupDeseaseTF(){
        deseaseTF.filterStrings(deseaseNames)
        deseaseTF.comparisonOptions = [.caseInsensitive]
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: deseaseTF.frame.width, height: 30))
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 14)
        header.text = "Pick your option"
        deseaseTF.resultsListHeader = header
        deseaseTF.theme.font = UIFont.systemFont(ofSize: 18)
        deseaseTF.theme.bgColor = .white
        deseaseTF.theme.borderColor = .black
        deseaseTF.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        deseaseTF.theme.cellHeight = 50
        deseaseTF.maxResultsListHeight = 200
        deseaseTF.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            self.deseaseIDs.append(self.dect[item.title] ?? 0)
            self.deseaseTF.text = item.title
        }

    }
    
    func addDrug(drug: Drug) {
        self.drugs.append(drug)
        let dict:[String:String?] = ["drug_id":drug.drugID,"general_name":drug.generalName,"dose":drug.dose,"frequency":drug.frequency,"comment":drug.comment,"dosage_format":drug.dosageFormat,"for_how_long_index":drug.forHowLongIndex,"for_how_long_duration":drug.forHowLongDuration,"food_placement":drug.foodPlacement]
        self.drugsDict.append(dict)
        drugsTableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addDrugBtn(_ sender: Any) {
        let vc: AddDrugViewController = currentStoryboard(.AddDrug).instantiateViewController(identifier: "AddDrugViewController")
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 10)), height: .custom(size: Float(600)), center: .center))
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    @IBAction func selectInsurence(_ sender: UIButton) {
        var insurencesNames:[String]                    = []
        insurencesNames = insurences.map(\.label!)
        insurencesDropDown.dataSource                   = insurencesNames
        insurencesDropDown.anchorView                   = sender
        insurencesDropDown.bottomOffset                 = CGPoint(x: 0.0, y: sender.frame.size.height)
        insurencesDropDown.direction                    = .bottom
        insurencesDropDown.show()
        insurencesDropDown.selectionAction = {[weak self] (index: Int , item: String) in
            guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
            self?.insurenceID = self?.insurences[index].value ?? 0
            //print("insurence id \(self?.insurences[index].value)")
        }
    }
    
    
    @IBAction func addPrescriptionBtnPressed(_ sender: Any) {
      //  let note = Note(labs: "labs", scans: "scans", medical_supplies: "medical_supplies")
        let params:[String:Any] = [
        "insurance": insurenceID,
        "diseases": self.deseaseIDs,
        "patient": patientID,
        "notes": [
            "labs":"dada",
            "scans":"adadsad",
            "medical_supplies": "sadasda"
        ],
        "drugs": drugsDict
    ]
        viewModel.addPrescription(prescription: params)
        
    }
}

extension AddPrescriptionVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingDaysCell", for: indexPath) as! WorkingDaysCell
        cell.titleLbl.text = drugs[indexPath.row].generalName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    
}
