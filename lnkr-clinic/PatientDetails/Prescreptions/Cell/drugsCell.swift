//
//  drugsCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 23/11/2022.
//

import UIKit

class drugsCell: UITableViewCell {

    @IBOutlet weak var drugDescription: UILabel!
    @IBOutlet weak var drugarName: UILabel!
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var drugImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        // Initialization code
    }
    
    func configureCell(drug:DrugModel) {
        drugName.text = drug.generalName
        drugarName.text = drug.dosageFormat
        drugDescription.text = (drug.dosageFormat ?? "") + " لمدة " + (drug.forHowLongIndex ?? "") + " ايام "
    }

}
