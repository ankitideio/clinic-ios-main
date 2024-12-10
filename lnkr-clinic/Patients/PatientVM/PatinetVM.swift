//
//  PatinetVM.swift
//  lnkr-clinic
//
//  Created by meet sharma on 03/05/23.
//

import Foundation

class PatientVM{
    func searchPatientApi(search:String,onSuccess:@escaping(([Patient]?)->())){
        WebService.service(API.searchPatinet,urlAppendId: "\(General.getUserID())/patientSearch?q=\(search)",service: .get) { (model:PatientBaseModel,jsonData,jsonSer) in
            onSuccess(model.data)
        }
    }
}
