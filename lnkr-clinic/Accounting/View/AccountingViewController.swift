//
//  AccountingViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 08/11/2022.
//

import UIKit

class AccountingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = AccountingViewModel()
    var accountingData:Accounting?
    var accountingList:[AccountingPatient] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setUpTableView()
        setUpCollection()
        viewModel.getAccounting(dentistID: General.getUserID())
        binData()
    }
    
    func binData(){
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.accountingList.bind { [weak self] data in
            guard let data = data else { return }
            self?.accountingData = data
            self?.accountingList = data.data?.patients ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AccountingTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountingTableViewCell")
    }
    
    func setUpCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AccountingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AccountingCollectionCell")
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AccountingViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountingCollectionCell", for: indexPath) as! AccountingCollectionCell
        guard let accounting = accountingData else {
            return cell
        }
        cell.configureCell(index: indexPath.row, accounting: accounting)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
}


extension AccountingViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountingTableViewCell") as! AccountingTableViewCell
        cell.configureCell(accountingPatient: accountingList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    
}
