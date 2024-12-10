//
//  AddDrugViewController.swift
//  lnkr-clinic
//
//  Created by Zaki on 14/11/2022.
//

import UIKit
import DropDown

protocol addDrugProtocol {
    func addDrug(drug:Drug)
}

class AddDrugViewController: UIViewController {
    
    
    @IBOutlet weak var DrugNameTxtField: UITextField!
    @IBOutlet weak var DosageTxtField: UITextField!
    @IBOutlet weak var selectTypeTxtField: UITextField!
    @IBOutlet weak var selectTimesTxtField: UITextField!
    @IBOutlet weak var selectPeriodTxtField: UITextField!
    @IBOutlet weak var forHowLongTxtField: UITextField!
    @IBOutlet weak var selectDayTxtField: UITextField!
    @IBOutlet weak var commentTxtField: UITextField!
    @IBOutlet weak var DropDownView: CustomOutlineView!
    @IBOutlet weak var DropDownView2: CustomOutlineView!
    @IBOutlet weak var DropDownView3: CustomOutlineView!
    @IBOutlet weak var DropDownView4: CustomOutlineView!
    
    
    let typeDropDown = DropDown()
    let typesCollection = ["قرص" , "كبسول" , "لبوس" , "امبول","ملعقة صغيرة","مرهم","كريم","ملعقة كبيرة","فيال"]
    
    
    let timesDropDown = DropDown()
    let TimesArray = ["مرة يوميا" , "مرتان يوميا" , "ثلاث مرات يوميا" , "اربع مرات يوميا"]
    
    let periodDropDown = DropDown()
    let PeriodArray = ["بعد الاكل" , "قبل الاكل"]
    
    let repeatnessDropDown = DropDown()
    let DayArray = ["يوم" , "اسبوع","شهر"]
    var delegate:addDrugProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typeDropDown.anchorView = DropDownView
        typeDropDown.dataSource = typesCollection
        
        timesDropDown.anchorView = DropDownView2
        timesDropDown.dataSource = TimesArray
        
        periodDropDown.anchorView = DropDownView3
        periodDropDown.dataSource = PeriodArray
        
        repeatnessDropDown.anchorView = DropDownView4
        periodDropDown.dataSource = DayArray
        
        typeDropDown.selectionAction = { [unowned self] (index: Int , item: String) in
            self.selectTypeTxtField.text = typesCollection[index]
        }
        
        
        timesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectTimesTxtField.text = TimesArray[index]
        }
        
        
        periodDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectPeriodTxtField.text = PeriodArray[index]

        }
        
        repeatnessDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectDayTxtField.text = DayArray[index]

        }
        
    }
    
    @IBAction func cancelBttnPressed(_ sender: Any) {
    }
    @IBAction func submitPressed(_ sender: Any) {
        let drug = Drug(drugID: "", generalName: DrugNameTxtField.text, dose: DosageTxtField.text, frequency: selectTimesTxtField.text, comment: commentTxtField.text, dosageFormat: selectTypeTxtField.text, forHowLongIndex: forHowLongTxtField.text, forHowLongDuration: selectDayTxtField.text, foodPlacement: selectPeriodTxtField.text)
        self.delegate?.addDrug(drug: drug)
        self.dismiss(animated: true)
    }
    
    @IBAction func selectTypeBttnPressed(_ sender: Any) {
        typeDropDown.show()
    }
    
    @IBAction func selectTimesBttnPressed(_ sender: Any) {
        timesDropDown.show()

    }
    
    @IBAction func selectPeriodTimePressed(_ sender: Any) {
        periodDropDown.show()

    }
    
    @IBAction func selectDayBttnPressed(_ sender: Any) {
        print("clicked")
        repeatnessDropDown.show()
    }
    

}
