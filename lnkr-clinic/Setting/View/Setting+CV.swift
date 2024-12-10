//
//  Setting+CV.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 09/11/2022.
//

import Foundation
import UIKit

enum settingCases:CaseIterable {
    case Physician
    case pricing
    case assistant
    case clinic
    case notifications
    case syndicate
    case security
    case requestUpdat
}

extension SettingsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionContent {
            return settingCases.allCases.count
        }
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionContent {
            
            switch indexPath.row {
            case 0:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "PHCell", for: indexPath) as! PhysicianCell
                return cell
            case 1:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "PricingCell", for: indexPath) as! PricingCell
                return cell
            case 2:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "AssistantCell", for: indexPath) as! AssistantCell
                return cell
            case 3:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "clinicCell", for: indexPath) as! ClinicCell
                return cell
            case 4:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "SyndicateCell", for: indexPath) as! SyndicateCell
                return cell
            case 5:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
                return cell
            case 6:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "SecurityCell", for: indexPath) as! SecurityCell
                return cell
            case 7:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "RequesUpdateCell", for: indexPath) as! RequesUpdateCell
                return cell
            default:
                let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: "PHCell", for: indexPath) as! PhysicianCell
                return cell
            }
        }
        
        // the Upper Collection View
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.configureCell(title: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionContent {
            return CGSize(width: collectionContent.frame.size.width, height: collectionContent.frame.size.height)
        }
        return CGSize(width: collectionView.frame.size.width / 2.5, height: collectionView.frame.size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath) as! SettingCell
        if collectionView == collectionContent {
            
        }else{
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            settingCase = settingCases.allCases[indexPath.row]
            if indexPath.row > 0 {
                firstEnter = false
            }
            
            if settingCase == .Physician && firstEnter {
                
            }else{
                changeCollectionStat(index: indexPath.row)
            }
            
        }
    }
    
    func changeCollectionStat(index: Int) {
        collectionContent.isScrollEnabled = true
            self.collectionContent.scrollToItem(at: IndexPath(row: index, section: 0), at: .init(), animated: true)
            self.collectionContent.layoutIfNeeded()
            self.collectionContent.isScrollEnabled = false
        }
    }
