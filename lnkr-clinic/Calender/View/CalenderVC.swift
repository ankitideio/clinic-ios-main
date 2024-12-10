//
//  CalenderVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import UIKit
import FSCalendar
import Presentr
class CalenderVC: UIViewController,FSCalendarDataSource,FSCalendarDelegate {
    
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    var formatter = DateFormatter()
    var requestFormatter = DateFormatter()
    var viewModel = CalenderViewModel()
    var events:[EventsData] = []

    var dateSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderView.locale = Locale(identifier: "en")
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.locale = Locale(identifier: "en")
        selectedDate.text = "\(formatter.string(from: Date()))"
        dateSelected = "\(formatter.string(from: Date()))"
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        viewModel.getEvents()
        bindData()
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
        
        viewModel.events.bind { events in
            DispatchQueue.main.async {
                self.events = events?.events ?? []
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.locale = Locale(identifier: "en")
        selectedDate.text = "\(formatter.string(from: date))"
        dateSelected = "\(formatter.string(from: date))"
        print(formatter.string(from: date))
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        calenderView.setCurrentPage(getNextMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        calenderView.setCurrentPage(getPreviousMonth(date: calenderView.currentPage), animated: true)
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    @IBAction func addVisitBtnPressed(_ sender: Any) {
        let vc: AddVisitViewController = currentStoryboard(.calender).instantiateViewController(identifier: "AddVisitViewController")
        vc.selectedDate = self.dateSelected
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 10)), height: .custom(size: Float(350)), center: .center))
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    @IBAction func addEventBtnPressed(_ sender: Any) {
        let vc: AddEventViewController = currentStoryboard(.calender).instantiateViewController(identifier: "AddEventViewController")
        vc.selectedDate = self.dateSelected
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 10)), height: .custom(size: Float(250)), center: .center))
        
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}



extension CalenderVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderCell") as! CalenderCell
        cell.titleTxtField.text = events[indexPath.row].title ?? ""
        return cell
    }
}
