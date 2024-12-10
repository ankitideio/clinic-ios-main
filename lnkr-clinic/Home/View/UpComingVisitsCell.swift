//
//  UpComingVisitsCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import UIKit

class UpComingVisitsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var visitStatus: UILabel!
    @IBOutlet weak var visitType: UILabel!
    @IBOutlet weak var visitTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(visit:Visit){
        self.title.text = visit.title
        self.visitStatus.text = visit.visitStatus
        self.visitType.text = visit.visitType
        self.visitTime.text = visit.start
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
