//
//  AssistantTableCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 03/12/2022.
//

import UIKit

class AssistantTableCell: UITableViewCell {

    @IBOutlet weak var assistantName: UILabel!
    @IBOutlet weak var assistantEmail: UILabel!
    @IBOutlet weak var assistantPhone: UILabel!
    @IBOutlet weak var assistantNationalID: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func configureCell(assistant:AssistantData){
        assistantName.text       = assistant.fullName
        assistantEmail.text      = assistant.email
        assistantPhone.text      = assistant.mobile
        assistantNationalID.text = assistant.nationalID
    }
    
}
