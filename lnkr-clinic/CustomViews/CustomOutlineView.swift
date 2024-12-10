//
//  CustomOutlineView.swift
//  lnkr-clinic
//
//  Created by Zaki on 12/11/2022.
//

import UIKit

class CustomOutlineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
      layer.borderWidth = 1
      layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    }
}
