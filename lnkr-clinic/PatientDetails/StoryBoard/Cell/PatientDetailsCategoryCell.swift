//
//  PatientDetailsCategoryCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import UIKit

class PatientDetailsCategoryCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            selectOrdeSelect(isSelected:isSelected)
        }
    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var selectionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title:String){
        self.title.text = title
    }
    
    func selectOrdeSelect(isSelected:Bool){
        
        if isSelected {
            selectionView.isHidden = false
            title.textColor = .white
        }else{
            selectionView.isHidden = true
            title.textColor = .lightGray
        }
    }

}
