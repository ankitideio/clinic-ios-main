//
//  PatientDetailsVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 11/11/2022.
//

import UIKit
class PatientDetailsVC: UIViewController {
    
    @IBOutlet weak var mainMenuCollection: UICollectionView!
    @IBOutlet weak var treatmentCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let treatmentOptions = ["DENTESTRY","PEDIATRICS","ENT","ORTHOPESICS","OPTHALMOLOGY","GYNECOLOGY AND INFEITIRY", "GENERAL SERGERY"]
    
    let detailsOptions  = ["PERSONAL INFO","TREATMENT","VISIT","PRESCRIPTIONS","LABS","SCANS","REPORTS"]
    var patientID:Int?
    var isFromPINCode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollections()
        registerTableCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setUpCollections(){
        mainMenuCollection.delegate    = self
        mainMenuCollection.dataSource  = self
        treatmentCollection.delegate   = self
        treatmentCollection.dataSource = self
        treatmentCollection.register(UINib(nibName: "SettingCell", bundle: nil), forCellWithReuseIdentifier: "SettingCell")
        mainMenuCollection.register(UINib(nibName: "PatientDetailsCategoryCell", bundle: nil), forCellWithReuseIdentifier: "PatientDetailsCategoryCell")
        self.treatmentCollection.selectItem(at:IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        self.mainMenuCollection.selectItem(at:IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
    
    @IBAction func backAction(_ sender: Any) {
        if isFromPINCode {
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: nil)
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension PatientDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainMenuCollection {
            return detailsOptions.count
        }
        
        return treatmentOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainMenuCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDetailsCategoryCell", for: indexPath) as! PatientDetailsCategoryCell
            cell.configureCell(title: detailsOptions[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SettingCell
            cell.configureCell(title: treatmentOptions[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainMenuCollection {
            mainMenuCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            changeTableStat(index: indexPath.row)
            if indexPath.row == 1 {
                treatmentCollection.isHidden = false
            }else{
                treatmentCollection.isHidden = true
                self.treatmentCollection.selectItem(at:IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            }
        }else if collectionView == treatmentCollection {
            treatmentCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            changeTableStat(index: patientCase.allCases.count + indexPath.row)
        }
    }
    
    func changeTableStat(index: Int) {
        tableView.isScrollEnabled = true
        self.tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: .middle, animated: false)
        self.tableView.layoutIfNeeded()
        self.tableView.isScrollEnabled = false
    }
    
}
