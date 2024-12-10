//
//  HomeVC+TV.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import Foundation
import UIKit

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noVisitsPlacholderStack.isHidden = upcomingVisits.count == 0 ? false : true
        return upcomingVisits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpComingVisitsCell", for: indexPath) as! UpComingVisitsCell
        cell.configureCell(visit: upcomingVisits[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}
