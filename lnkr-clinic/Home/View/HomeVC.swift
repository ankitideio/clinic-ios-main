//
//  HomeVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14 Heshvan 5783.
//

import UIKit
import SideMenu
import Presentr
import MBProgressHUD
class HomeVC: UIViewController {

    @IBOutlet weak var noVisitsPlacholderStack: UIStackView!
    @IBOutlet weak var prescriptionsCount: UILabel!
    @IBOutlet weak var patientsCount: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var upcomingTV: UITableView!
    let viewModel = HomeViewModel()
    var upcomingVisits:[Visit] = []
    var currentCellIndex = 0
    var timer:Timer?
    var images = ["slider1-en","slider2-en","slider3-en"]
    var hud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.items?[2].isEnabled = false
        configureSliderCollection()
        configureUpcomingTable()
        configurePageControl()
        startTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHome()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func fetchHome(){
        viewModel.fetchHome(userID: General.getUserID())
        viewModel.isLoading.bind { [weak self] isLoading in
            switch isLoading {
            case true:
                self?.showLoadingView()
                print("loading")
            case false:
                self?.hideLoadingView()
                print("finishLoading")
            }
        }
        
        viewModel.errorMessage.bind { [weak self] message in
            print("statusCode is ---------------- \(message?.message ?? "")")
            if message !=  nil {
                AlertsManager.showAlert(withTitle: "Sorry!", message: message?.message, viewController: self)
            }
        }
        
        viewModel.homeData.bind { [weak self] data in
            DispatchQueue.main.async {
                self?.patientsCount.text      = "\(data?.patients ?? 0)"
                self?.prescriptionsCount.text = "\(data?.prescriptions ?? 0)"
                self?.upcomingVisits          = data?.visits ?? []
                self?.upcomingTV.reloadData()
            }
        }
    }
    

    func configureSliderCollection(){
        sliderCollectionView.register(UINib(nibName: "sliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        sliderCollectionView.delegate           = self
        sliderCollectionView.dataSource         = self
        sliderCollectionView.isPagingEnabled    = false
    }
    
    func configureUpcomingTable(){
        upcomingTV.register(UINib(nibName: "UpComingVisitsCell", bundle: nil), forCellReuseIdentifier: "UpComingVisitsCell")
        upcomingTV.delegate     = self
        upcomingTV.dataSource   = self
    }
    
    func configurePageControl(){
        pageControl.numberOfPages   = images.count
        pageControl.currentPage     = currentCellIndex
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideImage), userInfo: nil, repeats: true)
    }
    
    @objc func slideImage(){
        let desiredPosition = (currentCellIndex < images.count - 1) ? currentCellIndex + 1 : 0
        sliderCollectionView.scrollToItem(at: IndexPath(item: desiredPosition, section: 0), at: .centeredHorizontally, animated: true)
    }

    
    @IBAction func openMenu(_ sender: Any) {
        guard let menu = currentStoryboard(.SideMenu).instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuNavigationController else {return}
        
        menu.leftSide = true
        menu.menuWidth = 200
        menu.statusBarEndAlpha = 0.0
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func findPatient(_ sender: Any) {
        print("blalalalala")
        let vc: FindPatientVC = currentStoryboard(.Home).instantiateViewController(identifier: "FindPatientVC")
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 10)), height: .custom(size: Float(200)), center: .center))
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
}
