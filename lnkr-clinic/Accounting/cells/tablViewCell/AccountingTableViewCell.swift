//
//  AccountingTableViewCell.swift
//  lnkr-clinic
//
//  Created by Zaki on 08/11/2022.
//

import UIKit

class AccountingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numOfVisits: UILabel!
    @IBOutlet weak var paidFees: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var discount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.blue.cgColor
        self.containerView.layer.cornerRadius = 10
    }

    func configureCell(dentestry:Dentistry) {
        self.nameLbl.text = dentestry.actions
        self.numOfVisits.text = "\(dentestry.patient ?? 0)"
        self.paidFees.text = "\(dentestry.paid ?? 0)"
        self.totalIncome.text = "\(dentestry.totalPaid ?? 0)"
        
    }
    
    func configureCell(accountingPatient:AccountingPatient){
        self.nameLbl.text = accountingPatient.fullName
        self.numOfVisits.text = "\(accountingPatient.totalData?.totalVisits ?? 0)"
        self.paidFees.text    = "\(accountingPatient.totalData?.feesPaid ?? 0)"
        self.totalIncome.text = "\(accountingPatient.totalData?.totalIncome ?? 0)"
    }
    
}
