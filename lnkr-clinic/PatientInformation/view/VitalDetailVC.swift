//
//  VitalDetailVC.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit

class VitalDetailVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var vwNoDataFound: UIView!
    @IBOutlet weak var heightSearchVw: NSLayoutConstraint!
    @IBOutlet weak var tblVwVitalList: UITableView!
    
    var viewModel = PatientInfoVM()
    var arrVital = [VitalRecordData]()
    var filtered = [VitalRecordData]()
    var isFitering = false
    var page = 1
    var pageM:Page?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSet()
    }
    
    //MARK: - FUNCTIONS
    func uiSet(){
        tblVwVitalList.register(UINib(nibName: "VitalDataListTVC", bundle: nil), forCellReuseIdentifier: "VitalDataListTVC")
        
        txtFldSearch.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            self.getVitalInfoApi()
        }
    }
    func getVitalInfoApi(){
        page = 1
        viewModel.getVitalInfoList(page: 1) { data in
            self.arrVital.removeAll()
            self.arrVital.append(contentsOf: data ?? [])
         
           if self.arrVital.count > 0 {
               self.tblVwVitalList.isHidden = false
               self.vwNoDataFound.isHidden = true
               self.heightSearchVw.constant = 50
            }else{
                self.tblVwVitalList.isHidden = true
                self.vwNoDataFound.isHidden = false
                self.heightSearchVw.constant = 0
            }
            self.tblVwVitalList.reloadData()
        }
    }
    func containsMonthValue(dateString: String, monthValue: Int) -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: dateString) ?? Date()
        let calendar = Calendar.current
        let month = calendar.component(.day, from: date)
        return month == monthValue
    }
    //MARK: - ACTION
    @IBAction func actionAddVitalData(_ sender: UIButton) {
        let  vc = currentStoryboard(.vitalDetail).instantiateViewController(identifier: "EditVitalDetailVC") as! EditVitalDetailVC
        vc.isComing = 0
        self.navigationController?.pushViewController(vc, animated: true)
        NotificationCenter.default.post(name: Notification.Name("NotificationEdit"), object: nil)
    }
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE METHOD
extension VitalDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFitering {
            if filtered.count == 0 {
                self.vwNoDataFound.isHidden = false
            }else{ self.vwNoDataFound.isHidden = true
            }
            return filtered.count
        }
        if arrVital.count == 0 {
            self.vwNoDataFound.isHidden = false
        }else{ self.vwNoDataFound.isHidden = true
        }
        return arrVital.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VitalDataListTVC", for: indexPath) as! VitalDataListTVC
        cell.btnEdit.addTarget(self, action: #selector(editData), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        let dateString =  arrVital[indexPath.row].createdDate ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let formattedDate = dateFormatter.string(from: date ?? Date())
        cell.lblDate.text = formattedDate
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let time = timeFormatter.date(from: dateString)
        timeFormatter.dateFormat = "h:mm a"
        let formattedTime = timeFormatter.string(from: time ?? Date())
        cell.lblTime.text = formattedTime
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let newDate = newDateFormatter.date(from: dateString)
        newDateFormatter.dateFormat = "dd MM yyyy"
        var formattedNewDate = newDateFormatter.string(from: newDate ?? Date())
        self.arrVital[indexPath.row].date = formattedNewDate
        print(self.arrVital[indexPath.row].date ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = 0
        let lastRowIndex = arrVital.count - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && pageM?.has_next ?? false{
            page += 1
            viewModel.getVitalInfoList(page: page) { data in
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.txtFldSearch.resignFirstResponder()
        let  vc = currentStoryboard(.vitalDetail).instantiateViewController(identifier: "EditVitalDetailVC") as! EditVitalDetailVC
        vc.createdDate = arrVital[indexPath.row].createdDate ?? ""
        vc.uuid = arrVital[indexPath.row].uuid ?? ""
        vc.arrVital = self.arrVital
        vc.index = indexPath.row
        vc.isComing = 1
        vc.callBack = {
            self.uiSet()
        }
    
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func editData(sender:UIButton){
        self.txtFldSearch.resignFirstResponder()
        let  vc = currentStoryboard(.vitalDetail).instantiateViewController(identifier: "EditVitalDetailVC") as! EditVitalDetailVC
        vc.isComing = 2
        vc.createdDate = arrVital[sender.tag].createdDate ?? ""
        vc.uuid = arrVital[sender.tag].uuid ?? ""
        vc.arrVital = self.arrVital
        vc.index = sender.tag
        vc.callBack = {
            self.heightSearchVw.constant = 50
            self.tblVwVitalList.isHidden = false
            self.vwNoDataFound.isHidden = true
        }
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension VitalDetailVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = txtFldSearch.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        if newText.count == 0 {
            isFitering = false
            self.tblVwVitalList.reloadData()
        }else{
            isFitering = true
            self.filtered = self.arrVital.filter {$0.date?.range(of: newText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
                    self.tblVwVitalList.reloadData()
          
        }
        return true
    }
}
