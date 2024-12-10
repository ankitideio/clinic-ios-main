//
//  HomeVC+sliderCollection.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import Foundation
import UIKit
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
        cell.configureCell(imageName: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentCellIndex = Int(scrollView.contentOffset.x / sliderCollectionView.frame.size.width)
        pageControl.currentPage = Int(currentCellIndex)
    }
}
