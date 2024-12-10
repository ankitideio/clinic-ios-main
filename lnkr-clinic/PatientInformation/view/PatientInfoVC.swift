//
//  PatientInfoVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class PatientInfoVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var clsnVwHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var clsnVwCategory: UICollectionView!
    
    //MARK: - VARIABLE
    var isSelect = 0
    var arrCategory = ["Personal info","Medical Info","Vital Data Signs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
    }
    
    //MARK: - FUNCTIONS
    func uiSet(){
        lblName.text = Store.patientName ?? ""
        self.tabBarController?.tabBar.isHidden = true
        let nib = UINib(nibName: "InfoTypeCVC", bundle: nil)
        clsnVwCategory.register(nib, forCellWithReuseIdentifier: "InfoTypeCVC")
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationEdit"), object: nil)
    }
    
    func setEditButton(){
        if isSelect == 2 {
            btnEdit.setImage(UIImage(named: "Frame 833"), for: .normal)
        }else{
            btnEdit.setImage(UIImage(named: "Frame 832"), for: .normal)
        }
        
    }
    //MARK: - GETNOTIFICATIONCENTER
    @objc func methodOfReceivedNotification(notification: Notification) {
        btnEdit.isHidden = false
        clsnVwHeight.constant = 50
        clsnVwCategory.isHidden = false
    }
    
    //MARK: - ACTIONS
    @IBAction func actionBack(_ sender: UIButton) {
     
            if btnEdit.isHidden == true{
                btnEdit.isHidden = false
                clsnVwHeight.constant = 50
                clsnVwCategory.isHidden = false
                NotificationCenter.default.post(name: Notification.Name("EditPatientInfo"), object: nil)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        clsnVwCategory.isHidden = true
        clsnVwHeight.constant = 0
        btnEdit.isHidden = true
        if isSelect == 0 {
            NotificationCenter.default.post(name: Notification.Name("NotificationPersnalInfo"), object: nil)
         
        }else if isSelect == 1{
            NotificationCenter.default.post(name: Notification.Name("NotificationMedicalInfo"), object: nil)
            
        }else{
            
            let  vc = currentStoryboard(.vitalDetail).instantiateViewController(identifier: "EditVitalDetailVC") as! EditVitalDetailVC
            vc.isComing = 0
            vc.callBack = {
                self.btnEdit.isHidden = false
                self.clsnVwHeight.constant = 50
                self.clsnVwCategory.isHidden = false
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension PatientInfoVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoTypeCVC", for: indexPath) as! InfoTypeCVC
        cell.lblName.text = arrCategory[indexPath.row]
        if isSelect == indexPath.row{
            cell.vwSelectCategory.backgroundColor = #colorLiteral(red: 0.1268709004, green: 0.4017826915, blue: 0.8744068742, alpha: 1)
            cell.lblName.textColor = .white
        }else{
            cell.vwSelectCategory.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9764705882, blue: 0.9882352941, alpha: 1)
            cell.lblName.textColor = #colorLiteral(red: 0.01568627451, green: 0.05098039216, blue: 0.1450980392, alpha: 1)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = arrCategory[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width+30, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelect = (isSelect == indexPath.row) ? 0 : indexPath.row
        clsnVwCategory.reloadData()
        if isSelect == 0 {
            scrollVw.setContentOffset(.zero, animated: true)
        }else if isSelect == 1{
            scrollVw.setContentOffset(.zero, animated: true)
            scrollVw.setContentOffset(CGPoint(x: scrollVw.frame.size.width*1, y: 0), animated: true)
        }else{
            scrollVw.setContentOffset(.zero, animated: true)
            scrollVw.setContentOffset(CGPoint(x: scrollVw.frame.size.width*2, y: 0), animated: true)
        }
        setEditButton()
    }
}
