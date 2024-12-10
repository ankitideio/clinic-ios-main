//
//  PrescriptionTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13/11/2022.
//

import UIKit

class PrescriptionTableCell: UITableViewCell {

    @IBOutlet weak var insurenceLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var prescriptionIDLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(prescription:Prescription) {
        self.prescriptionIDLbl.text = "PrescriptionID: \(prescription.uuid ?? "")"
        self.createdAtLbl.text = "Created at: \(prescription.createdDate ?? "")"
        self.insurenceLbl.text = "Insurence: \(prescription.insurancee ?? "")"
    }
    
}
