//
//  AddLabVC.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 20/11/2022.
//

import UIKit

protocol AddLabProtocol {
    func refresdhLabs()
}

class AddLabVC: UIViewController {

    
    @IBOutlet weak var labNameTxt: CustomTextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgBtn: UIButton!
    var selectedImage = UIImage()
    var isAddScan:Bool?
    var viewModel = LabsViewModel()
    var delegate:AddLabProtocol?
    let labViewModel = AddLabsViewModel()
    var patientId = 0
    private var Addedlabs : AddLabModelResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = isAddScan ?? false ? "Add Scan" : "Add Lab"
        getSelectedImage()
        setUpViewModel()
        
        
    }
    
    //setUp ViewModel
    func setUpViewModel(){
        labViewModel.OnAddLabSucsess = { [weak self] labs in
            self?.Addedlabs = labs
            AlertsManager.showAlert(withTitle: "Message", message: self?.Addedlabs?.message, viewController: self, showingCancelButton: false, showingOkButton: true, cancelHandler: nil, actionTitle: "OK", actionStyle: .default) { _ in
                self?.delegate?.refresdhLabs()
                self?.dismiss(animated: true)
            }
        }
        
        labViewModel.isLoading = { [weak self] isLoading in
            switch isLoading {
            case true:
                self?.showLoadingView()
            case false:
                self?.hideLoadingView()
            }
        }
    }
    
    func getSelectedImage(){
        DispatchQueue.global().async {
            AttachmentHandler.shared.imagePickedBlock =  { [weak self] (image) in
                self?.labViewModel.imageData = image.lowQualityJPEGNSData
                self?.selectedImage = image
                self?.imgBtn.setBackgroundImage(image, for: .normal)
            }
        }
    }
    @IBAction func AddPhoto(_ sender: Any) {
        AttachmentHandler.shared.showAttachmentActionSheetForImage(vc: self)
    }
    
    @IBAction func submit(_ sender: Any) {
        let labURL  = "https://lnkrbackend.link/api/patient/\(patientId)/labs/"
        let scanURL = "https://lnkrbackend.link/api/patient/\(patientId)/scans/"
        
        if isAddScan ?? false {
           labViewModel.AddLab(File: labViewModel.imageData,url: scanURL ,WithName: "scan_result" , labName: labNameTxt.text ?? "",quryItem: "scan_name", patientID: "\(patientId)" )
        }else{
            labViewModel.AddLab(File: labViewModel.imageData,url: labURL ,WithName: "lab_result" , labName: labNameTxt.text ?? "",quryItem: "lab_name", patientID: "\(patientId)" )
        }
    }
}
extension UIImage {

    var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)! }
    var highQualityJPEGNSData: Data    { return self.jpegData(compressionQuality: 0.75)!}
    var mediumQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.5)! }
    var lowQualityJPEGNSData: Data     { return self.jpegData(compressionQuality: 0.25)!}
    var lowestQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.0)! }

}
