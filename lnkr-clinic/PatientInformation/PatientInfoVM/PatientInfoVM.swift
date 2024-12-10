//
//  PatientInfoVM.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//

import Foundation

class PatientInfoVM{
    //MARK: - GET PERSNALINFO API
    
    func pesnalInfoApi(patientId:Int,onSucess:@escaping((PersonalInfo?)->())){
        WebService.service(API.persnalInfo,urlAppendId: "\(patientId)/",service: .get) { (model:PersonaLInfoBase,jsonData,jsonSer) in
            onSucess(model.data)
        }
    }
    //MARK: - UPDATE PATIENTINFO API
    
    func updatePersnalInfoApi(cardNo:String,pinCode:String,onSucess:@escaping((PersonalInfo?)->())){
        let param:parameters = ["card_number": cardNo,"pincode": pinCode]
        print(param)
        WebService.service(API.persnalInfo,urlAppendId: "\(Store.patientId ?? 0)/register_patient_card/",param: param,service: .put) { (model:PersonaLInfoBase,jsonData,jsonSer) in
            
            onSucess(model.data)
        }
        
    }
    
    //MARK: - GET MEDICALINFO API
    
    func medicalInfoApi(patientId:Int,onSucess:@escaping((MedicalInfoData?)->())){
        WebService.service(API.persnalInfo,urlAppendId: "\(patientId)/medical_info/",service: .get) { (model:MedicalInfoModel,jsonData,jsonSer) in
            onSucess(model.data)
        }
    }
    
    //MARK: - UPDATE MEDICALINFO API
    
    func updateMedicalInfoApi(materialStatus:String,smoking:Bool,alcohol:Bool,bloodType:String,drugAllergy:String,foodAllergy:String,diabetes:Bool,onSucess:@escaping((PersonalInfo?)->())){
        let param:parameters = ["marital_status": materialStatus,"smoking": smoking,"alcohol":alcohol,"blood_type":bloodType,"drug_allergy":drugAllergy,"food_allergy":foodAllergy,"diabetes":diabetes]
        print(param)
        WebService.service(API.persnalInfo,urlAppendId: "\(Store.patientId ?? 0)/medical_info/",param: param,service: .put) { (model:PersonaLInfoBase,jsonData,jsonSer) in
            showSwiftyAlert("", model.message ?? "", true)
            onSucess(model.data)
        }
        
    }
    //MARK: - ADD VITALINFO API
    func addVitalDetail(weight:String,height:Double,bloodPressure:String,temprature:String,sugarLevel:String,oxygenSaturation:String,pulse:String,race:String,other:String,onSucess:@escaping(()->())){
        let param: parameters = ["weight":weight,"height":height,"blood_pressure":bloodPressure,"sugar_level": sugarLevel,"temperature":temprature,"oxygen_saturation":oxygenSaturation,"pulse":pulse,"other":other,"race": race]
        WebService.service(API.persnalInfo,urlAppendId: "\(Store.patientId ?? 0)/health_records/",param: param,service: .post) { (model:VitalInfoModel,jsonData,jsonSer) in
            showSwiftyAlert("", model.message ?? "", true)
            onSucess()
        }
    }
    
    //MARK: - UPDATE VITALINFO API
    func updateVitalDetail(weight:String,height:Double,bloodPressure:String,temprature:String,sugarLevel:String,oxygenSaturation:String,pulse:String,bmi:String,createdDate:String,uuid:String,rece:String,other:String,onSucess:@escaping(()->())){
        let param: parameters = ["weight":weight,"height":height,"blood_pressure":bloodPressure,"sugar_level": sugarLevel,"temperature":temprature,"oxygen_saturation":oxygenSaturation,"pulse":pulse,"race": rece,"BMI":bmi,"created_date":createdDate,"other": other]
        WebService.service(API.persnalInfo,urlAppendId: "\(Store.patientId ?? 0)/health_records/",param: param,service: .post) { (model:VitalInfoModel,jsonData,jsonSer) in
            showSwiftyAlert("", model.message ?? "", true)
            onSucess()
        }
    }
    //MARK: - GET VITALINFOLIST API
    func getVitalInfoList(page:Int,onSucess:@escaping(([VitalRecordData]?)->())){
        WebService.service(API.persnalInfo,urlAppendId:"\(Store.patientId ?? 0)/\(page)/health_records/",service: .get) { (model:VitalRecordModel,jsonData,jsonSer) in
            onSucess(model.data)
        }
    }
   
    //MARK: - GET VITALINFODETAIL API
    func getVitalInfoDetail(uuid:String,onSucess:@escaping((VitalDetailData?)->())){
        WebService.service(API.persnalInfo,urlAppendId:"\(Store.patientId ?? 0)/health_records/\(uuid)/",service: .get) { (model:VitalDetailModel,jsonData,jsonSer) in
            onSucess(model.data)
        }
    }
}
