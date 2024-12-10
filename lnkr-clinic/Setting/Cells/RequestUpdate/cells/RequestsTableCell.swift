//
//  RequestsTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 04/12/2022.
//

import UIKit

class RequestsTableCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var createdAt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(request:RequestsData) {
        title.text = request.title
        createdAt.text = request.createdDate
    }
    
}
