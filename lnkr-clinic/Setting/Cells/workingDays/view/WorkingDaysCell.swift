//
//  WorkingDaysCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 10/11/2022.
//

import UIKit

class WorkingDaysCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title:String) {
        titleLbl.text = title
    }
    
}
