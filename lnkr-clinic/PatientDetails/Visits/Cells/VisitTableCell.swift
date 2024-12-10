//
//  VisitTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13/11/2022.
//

import UIKit

class VisitTableCell: UITableViewCell {

    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var scheduledAtLbl: UILabel!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var visitCostLbl: UILabel!
    @IBOutlet weak var visitTypeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(visit:VisitModel){
        self.scheduledAtLbl.text = "ScheduledAt: \(visit.scheduledDate ?? "")"
        self.statusLbl.text = "Status: \(visit.visitStatus ?? "")"
        self.totalLbl.text  = "Total: \(visit.totalCost ?? "")"
        self.discountLbl.text = "discount: \(visit.patientDiscount ?? "")"
        self.visitCostLbl.text = "visitCost: \(visit.visitCost ?? "")"
        self.visitTypeLbl.text = "visitType: \(visit.visitType ?? "")"
    }
    
}
