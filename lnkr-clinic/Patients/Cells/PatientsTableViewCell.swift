//
//  PatientsTableViewCell.swift
//  LnkrClinic
//
//  Created by Zaki on 06/11/2022.
//

import UIKit

class PatientsTableViewCell: UITableViewCell {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var patientAgeLbl: UILabel!
    @IBOutlet weak var PatientMobileNumLbl: UILabel!
    @IBOutlet weak var PatientGenderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.ContainerView.layer.borderWidth = 1
//        self.ContainerView.layer.borderColor = UIColor.blue.cgColor
        self.ContainerView.layer.cornerRadius = 10
        
        
//        patientImage?.layer.cornerRadius = (patientImage?.frame.size.width ?? 0.0) / 2
//        patientImage?.clipsToBounds = true
//        patientImage?.layer.borderWidth = 3.0
//        patientImage?.layer.borderColor = UIColor.white.cgColor
    }

    func configureCell(patient:Patient){
        self.patientNameLbl.text = patient.fullName
//        self.patientAgeLbl.text  = patient.birthdate
        self.PatientMobileNumLbl.text = "+\(patient.patientMobile ?? "")"
//        self.PatientGenderLbl.text    = patient.gender
//        self.patientImage.setImage(with: patient.profilePic ?? "")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
