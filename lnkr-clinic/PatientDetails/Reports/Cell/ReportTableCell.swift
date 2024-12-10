//
//  ReportTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit

class ReportTableCell: UITableViewCell {

    
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var reportTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    func configureCell(report:Report){
        self.reportTitle.text = "title: \(report.title)"
        self.createdAtLbl.text = "Created at: \(report.createdDate)"
    }
    
}
