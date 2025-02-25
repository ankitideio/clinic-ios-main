//
//  CustomTextField.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13 Heshvan 5783.
//

import Foundation
import UIKit
@IBDesignable
open class CustomTextField:UITextField{

   private var labelPlaceholderTitleTop:NSLayoutConstraint!
   private var labelPlaceholderTitleCenterY:NSLayoutConstraint!
   private var labelPlaceholderTitleLeft:NSLayoutConstraint!

    @IBInspectable var allowToShrinkPlaceholderSizeOnEditing = true
    @IBInspectable var shrinkSizeOfPlaceholder:CGFloat = 0

    @IBInspectable var placeHolderColor:UIColor = .lightGray{
        didSet{
            labelPlaceholderTitle.textColor = placeHolderColor
        }
    }
    open override var font: UIFont?{
        didSet{
            labelPlaceholderTitle.font = font
        }
    }
//    @IBInspectable var heightOfBottomLine:CGFloat = 50{
//        didSet{
//            heightAnchorOfBottomLine.constant = heightOfBottomLine
//        }
//    }

    open override var leftView: UIView?{
        didSet{
            if let lv = leftView{
                labelPlaceholderTitleLeft.constant = lv.frame.width+leftPadding
            }
        }
    }

    @IBInspectable var leftPadding:CGFloat = 10{
        didSet{
            labelPlaceholderTitleLeft.constant = leftPadding
        }
    }


    @IBInspectable var errorText:String = ""{
        didSet{
            self.labelError.text = errorText
        }
    }
    @IBInspectable var errorColor:UIColor = .red{
        didSet{
            labelError.textColor = errorColor
        }
    }
    @IBInspectable var errorFont:UIFont = UIFont.systemFont(ofSize: 12){
        didSet{
            self.labelError.font = errorFont
        }
    }

    @IBInspectable var shakeIntensity:CGFloat = 5

   //private var heightAnchorOfBottomLine:NSLayoutConstraint!

    lazy var labelPlaceholderTitle:UILabel={
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = self.font
        label.backgroundColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var labelError:UILabel={
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = self.errorText
        label.textAlignment = .right
        label.font = self.errorFont
        label.textColor = errorColor
        return label
    }()

//    let bottonLineView:UIView={
//        let view = UIView()
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        //view.backgroundColor = .lightGray
//        view.layer.cornerRadius = 10
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initalSetup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initalSetup()
    }

    override open func prepareForInterfaceBuilder() {
        self.initalSetup()
    }

    open override func awakeFromNib() {
        self.labelError.isHidden = true
    }

    func initalSetup(){

        self.labelPlaceholderTitle.text = placeholder
        placeholder = nil
        borderStyle = .roundedRect
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.layer.cornerRadius = 10
        //bottonLineView.removeFromSuperview()

        

        addSubview(labelPlaceholderTitle)
        labelPlaceholderTitleLeft = labelPlaceholderTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding)
        labelPlaceholderTitleLeft.isActive = true
        //labelPlaceholderTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        //labelPlaceholderTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelPlaceholderTitleTop = labelPlaceholderTitle.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        labelPlaceholderTitleTop.isActive = false

        labelPlaceholderTitleCenterY = labelPlaceholderTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        labelPlaceholderTitleCenterY.isActive = true
        
//        addSubview(bottonLineView)
//        bottonLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
//        bottonLineView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
//        bottonLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
//
//        heightAnchorOfBottomLine = bottonLineView.heightAnchor.constraint(equalToConstant: heightOfBottomLine)
       // heightAnchorOfBottomLine.isActive = true
//----------------------
//----------------------

        addSubview(labelError)
        labelError.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        labelError.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        labelError.topAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true


        addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)


    }

    func animateLabel(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func textFieldDidChange(){



        if let enteredText = text,enteredText != "" {
            if labelPlaceholderTitleCenterY.isActive{
                labelPlaceholderTitle.textAlignment = .center
                labelPlaceholderTitleCenterY.isActive = false
                labelPlaceholderTitleTop.isActive = true
                
                labelPlaceholderTitleTop.constant = -5
                if allowToShrinkPlaceholderSizeOnEditing{
                    let currentFont = font == nil ? UIFont.systemFont(ofSize: 16) : font!
                    let shrinkSize = shrinkSizeOfPlaceholder == 0 ? currentFont.pointSize-3 : shrinkSizeOfPlaceholder
                    labelPlaceholderTitle.font = UIFont.init(descriptor: currentFont.fontDescriptor, size:shrinkSize)
                }
                animateLabel()
            }
        }else{
            labelPlaceholderTitle.textAlignment = .left
            labelPlaceholderTitleCenterY.isActive = true
            labelPlaceholderTitleTop.isActive = false
            labelPlaceholderTitleTop.constant = 0
            labelPlaceholderTitle.font = font
            animateLabel()
        }
    }

    
    
    
    


    @objc public func showError(){
        self.labelError.isHidden = false
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - shakeIntensity, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + shakeIntensity, y: center.y))
        layer.add(animation, forKey: "position")
    }

    @objc public func hideError(){
        self.labelError.isHidden = true
    }

}
