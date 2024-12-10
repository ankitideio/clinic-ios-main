//
//  sliderCell.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import UIKit

class sliderCell: UICollectionViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(imageName:String) {
        self.imageOutlet.image = UIImage(named: imageName)
    }

}
