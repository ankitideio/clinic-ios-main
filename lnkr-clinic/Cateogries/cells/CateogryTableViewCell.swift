//
//  CateogryTableViewCell.swift
//  lnkr-clinic
//
//  Created by Zaki on 09/11/2022.
//

import UIKit

protocol YourCellDelegate : class {
    func didPressButton(_ tag: Int)
}

class CateogryTableViewCell: UITableViewCell {
    var cellDelegate: YourCellDelegate?
    @IBOutlet weak var deleteBttn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cateogryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.blue.cgColor
        self.containerView.layer.cornerRadius = 10
        // Initialization code
    }
    
    func configureCell(cateogry:Cateogry){
        self.cateogryName.text = cateogry.name
    }
    
    @IBAction func deleteBttnPressed(_ sender: Any) {
        cellDelegate?.didPressButton((sender as AnyObject).tag)
    }
}
