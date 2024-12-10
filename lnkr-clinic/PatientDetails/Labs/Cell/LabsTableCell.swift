//
//  LabsTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit

class LabsTableCell: UITableViewCell {

    @IBOutlet weak var labImg: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configurCell(lab:Lab){
        labImg.setImage(with: lab.labResult ?? "")
        self.labName.text = lab.labName
        self.createdAtLbl.text = lab.createdDate
    }
    
    func configurCell(scan:Scan){
        self.labImg.setImage(with: scan.scanResult)
        self.labName.text = scan.scanName
        self.createdAtLbl.text = scan.createdDate
    }
    
}
