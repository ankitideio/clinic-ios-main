//
//  PatientDetails+TV.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import Foundation
import UIKit
extension PatientDetailsVC:UITableViewDelegate,UITableViewDataSource {
    func registerTableCells(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PersonalInfoCell", bundle: nil), forCellReuseIdentifier: "PersonalInfoCell")
        tableView.register(UINib(nibName: "DentestryCell", bundle: nil), forCellReuseIdentifier: "DentestryCell")
        tableView.register(UINib(nibName: "VisitsCell", bundle: nil), forCellReuseIdentifier: "VisitsCell")
        tableView.register(UINib(nibName: "PrescriptionCell", bundle: nil), forCellReuseIdentifier: "PrescriptionCell")
        tableView.register(UINib(nibName: "LabsCell", bundle: nil), forCellReuseIdentifier: "LabsCell")
        tableView.register(UINib(nibName: "ScansCell", bundle: nil), forCellReuseIdentifier: "ScansCell")
        tableView.register(UINib(nibName: "ReportsCell", bundle: nil), forCellReuseIdentifier: "ReportsCell")
        tableView.register(UINib(nibName: "ENTCell", bundle: nil), forCellReuseIdentifier: "ENTCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patientCase.allCases.count + treatmentCase.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoCell", for: indexPath) as! PersonalInfoCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DentestryCell", for: indexPath) as! DentestryCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsCell", for: indexPath) as! VisitsCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrescriptionCell", for: indexPath) as! PrescriptionCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabsCell", for: indexPath) as! LabsCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScansCell", for: indexPath) as! ScansCell
            cell.patientID = self.patientID ?? 0
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportsCell", for: indexPath) as! ReportsCell
            cell.patirntID = self.patientID ?? 0
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DentestryCell", for: indexPath) as! DentestryCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ENTCell", for: indexPath) as! ENTCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.height
    }
}
