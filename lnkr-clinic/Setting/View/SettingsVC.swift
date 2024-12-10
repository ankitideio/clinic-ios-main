//
//  SettingsVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/11/2022.
//

import UIKit

class SettingsVC: UIViewController {
    
    let categories = ["PHYSICIAN","PRICING","ACCOUNT INFO","CLINIC","SYNDICATE","NOTIFICATION","SECURITY","REQUEST UPDATE"]
    var settingCase:settingCases = .Physician
    var firstEnter = true
    @IBOutlet weak var collectionContent: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureContentCollection()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SettingCell", bundle: nil), forCellWithReuseIdentifier: "SettingCell")
        self.collectionView.selectItem(at:IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        self.collectionView(self.collectionView, didSelectItemAt:IndexPath(item: 0, section: 0))
    }
    
    func configureContentCollection(){
        collectionContent.register(UINib(nibName: "PhysicianCell", bundle: nil), forCellWithReuseIdentifier: "PHCell")
        collectionContent.register(UINib(nibName: "PricingCell", bundle: nil), forCellWithReuseIdentifier: "PricingCell")
        collectionContent.register(UINib(nibName: "ClinicCell", bundle: nil), forCellWithReuseIdentifier: "clinicCell")
        collectionContent.register(UINib(nibName: "AssistantCell", bundle: nil), forCellWithReuseIdentifier: "AssistantCell")
        collectionContent.register(UINib(nibName: "NotificationsCell", bundle: nil), forCellWithReuseIdentifier: "NotificationsCell")
        collectionContent.register(UINib(nibName: "SyndicateCell", bundle: nil), forCellWithReuseIdentifier: "SyndicateCell")
        collectionContent.register(UINib(nibName: "SecurityCell", bundle: nil), forCellWithReuseIdentifier: "SecurityCell")
        collectionContent.register(UINib(nibName: "RequesUpdateCell", bundle: nil), forCellWithReuseIdentifier: "RequesUpdateCell")
        collectionContent.delegate = self
        collectionContent.dataSource = self
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
