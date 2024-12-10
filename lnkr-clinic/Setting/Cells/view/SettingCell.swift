//
//  SettingCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/11/2022.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    
    override var isSelected: Bool {
        didSet {
            selectOrdeSelect(isSelected: isSelected)
        }
    }
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var settingCategoryTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title:String){
        settingCategoryTitle.text = title
    }
    
    func selectOrdeSelect(isSelected:Bool){
        
        if isSelected  {
            selectionView.isHidden = false
            settingCategoryTitle.textColor = .blue
        }else{
            selectionView.isHidden = true
            settingCategoryTitle.textColor = .lightGray
        }
    }
}
