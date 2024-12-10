//
//  VitalDataListTVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class VitalDataListTVC: UITableViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
