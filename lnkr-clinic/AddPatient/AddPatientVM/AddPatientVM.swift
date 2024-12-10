//
//  AddPatientVM.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//

import Foundation

class AddPatientVM{
    //MARK: - ADDPATIENT API
    func addPatientApi(name:String,mobile:String,nationalId:String,onSucess:@escaping(()->())){
        let param:parameters = ["full_name": name,"mobile": mobile,"national_id": nationalId]
        print(param)
        WebService.service(API.addPatient,param: param,service: .post) { (model:PersonaLInfoBase,jsonData,jsonSer) in
            showSwiftyAlert("", model.message ?? "", true)
            onSucess()
        }

        
    }
}
