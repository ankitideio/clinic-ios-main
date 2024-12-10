//
//  CateogriesViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 09/11/2022.
//

import UIKit
import Presentr

class CateogriesViewController: UIViewController , UITextFieldDelegate ,AddCateogryProtocol , YourCellDelegate{
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchCateogryTxtField: UITextField!
    @IBOutlet weak var addBttn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = CateogriesViewModel()
    var cateogries:[Cateogry] = []
    var filtered              = [Cateogry]()
    var isFitering            = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate              = self
        tableView.dataSource            = self
        searchCateogryTxtField.delegate = self
        tableView.register(UINib(nibName: "CateogryTableViewCell", bundle: nil), forCellReuseIdentifier: "CateogryTableViewCell")
        // Do any additional setup after loading the view.
        viewModel.fetchCateogries(clinicID: General.getClinicID())
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    func bindData(){
        
        viewModel.isLoading.bind { isLoading in
            switch isLoading {
            case true:
                self.showLoadingView()
            case false:
                self.hideLoadingView()
            }
        }
        
        viewModel.cateogries.bind { cateogries in
            DispatchQueue.main.async {
                self.cateogries.append(contentsOf: cateogries ?? [])
                self.tableView.reloadData()
            }
        }
        
        viewModel.successDeleteMessgae.bind { message in
            guard let message = message else { return }
            AlertsManager.showAlert(withTitle: "SUCESS", message: message, viewController: self, showingCancelButton: false, showingOkButton: false)
        }
        
    }
    
    func refreshCategories() {
        self.cateogries.removeAll()
        viewModel.fetchCateogries(clinicID: General.getClinicID())
    }
    
    
    func didPressButton(_ tag: Int) {
        AlertsManager.showAlert(withTitle: "Delete", message: "Are you sure you want to delete cateogry", viewController: self, showingCancelButton: true, showingOkButton: true, cancelHandler: nil, actionTitle: "Delete", actionStyle: .default) { _ in
            self.viewModel.deleteCateogry(clinicID: General.getClinicID(), cateogryID: self.cateogries[tag].uuid ?? "")
            if self.isFitering {
                self.filtered.remove(at: tag)
            }else{
                self.cateogries.remove(at: tag)
            }
            self.tableView.reloadData()
            
        }
    }
    
    
    @IBAction func addBttnPressed(_ sender: Any) {
        let vc: AddCateogryViewController = currentStoryboard(.Cateogries).instantiateViewController(identifier: "AddCateogryViewController") as! AddCateogryViewController
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 10)), height: .custom(size: Float(300)), center: .center))
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    
    
}

extension CateogriesViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CateogryTableViewCell") as! CateogryTableViewCell
        cell.cellDelegate = self
        cell.deleteBttn.tag = indexPath.row
        if isFitering {
            cell.configureCell(cateogry: filtered[indexPath.row])
        }else{
            cell.configureCell(cateogry: cateogries[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFitering {
            return filtered.count
        }
        return cateogries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}

extension CateogriesViewController:UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = searchCateogryTxtField.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        
        
        if newText.count == 0 {
            isFitering = false
            self.tableView.reloadData()
        }else{
            isFitering = true
            self.filtered = cateogries.filter {$0.name?.range(of: newText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
            self.tableView.reloadData()
        }
        return true
    }
}
