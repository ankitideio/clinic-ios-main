//
//  AccountingCollectionCell.swift
//  lnkr-clinic
//
//  Created by Zaki on 08/11/2022.
//

import UIKit

class AccountingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var DetailsNum: UILabel!
    @IBOutlet weak var DatailsName: UILabel!
    @IBOutlet weak var TotalDetLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.blue.cgColor
        self.containerView.layer.cornerRadius = 10
    }
    
    func configureCell(index:Int , accounting:Accounting) {
        switch index {
        case 0:
            DetailsNum.text = "\(accounting.data?.totalPatients ?? 0)"
            DatailsName.text   = "Total Patients"
        case 1:
            DetailsNum.text = "\(accounting.data?.totalIncome ?? 0)"
            DatailsName.text   = "Total Income"
        case 2:
            DetailsNum.text = "\(accounting.data?.totalVisitsCost ?? 0)"
            DatailsName.text   = "Total Earnings"
        default:
            print("default")
        }
    }

}
