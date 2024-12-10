//
//  General.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
import UIKit

class General : NSObject {
    
    static let shared = General()
    static let userDefault = UserDefaults.standard
    static var userData : UserInfo?
    static func setUserData(data:UserInfo?){
        setLoginState(isLogin: true)
        setUserToken(name: data?.access)
        setUserID(ID: data?.user?.dentist?.id)
        setDentistUuid(userQualifications: data?.user?.uuid)
        setUserRefresh(refresh: data?.refresh)
        setClinicID(userClinic: data?.user?.dentist?.clinic?[0])
        setUserFullNAme(userFullName: data?.user?.dentist?.full_name)
        setDentistMobile(dentistMobile: data?.user?.mobile)
        setNationalID(nationalID: data?.user?.national_id)
        setEmail(dentistEmail: data?.user?.email)
        setSyndicateID(syndicateID: data?.user?.dentist?.syndicate_id)
        setDentistQualifications(userQualifications: data?.user?.dentist?.qualifications)
        setFirstvisit(firistVisit: data?.user?.dentist?.pricing?.first_visit)
        setConsultation(consultation: data?.user?.dentist?.pricing?.consultation)
        setRepeatVisit(repeatVisit: data?.user?.dentist?.pricing?.repeat_visit)
    }
    
    static func navigateToTabBarBYIndex(index : Int,vc:UIViewController) {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        let tabBarController = keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = index
        vc.dismiss(animated: true, completion: {
            vc.navigationController?.popToRootViewController(animated: false)
        })
    }
    
    static func setLoginState(isLogin:Bool?){
        userDefault.set(isLogin ,forKey: "isLogin")
    }
    
    static func setUserToken(name:String?){
        userDefault.set(name ,forKey: "userToken")
    }
    
    static func setUserID(ID:Int?){
        userDefault.set(ID ,forKey: "userID")
    }
    
    static func getUserLogin() -> Bool {
        return userDefault.value(forKey: "isLogin") as? Bool ?? false
    }
   
    static func getUserToken() -> String {
        return userDefault.value(forKey: "userToken") as? String ?? ""
    }
    
    static func getUserID() -> Int {
        return userDefault.value(forKey: "userID") as? Int ?? 0
    }
    
    static func setUserRefresh(refresh:String?){
        userDefault.set(refresh ,forKey: "userRefresh")
    }
    
    static func getUserRefresh() -> String {
        return userDefault.value(forKey: "userRefresh") as? String ?? ""
    }
    
    static func setClinicID(userClinic:String?){
        userDefault.set(userClinic ,forKey: "userClinic")
    }
    static func getClinicID() -> String {
        return userDefault.value(forKey: "userClinic") as? String ?? ""
    }
    
    static func setUserFullNAme(userFullName:String?){
        userDefault.set(userFullName ,forKey: "userFullName")
    }
    static func getUserFullNAme() -> String {
        return userDefault.value(forKey: "userFullName") as? String ?? ""
    }
    
    static func setDentistMobile(dentistMobile:String?){
        userDefault.set(dentistMobile ,forKey: "dentistMobile")
    }
    static func getDentistMobile() -> String {
        return userDefault.value(forKey: "dentistMobile") as? String ?? ""
    }
    
    static func setNationalID(nationalID:String?){
        userDefault.set(nationalID ,forKey: "nationaID")
    }
    static func getNationalID() -> String {
        return userDefault.value(forKey: "nationaID") as? String ?? ""
    }
    
    static func setEmail(dentistEmail:String?){
        userDefault.set(dentistEmail ,forKey: "dentistEmail")
    }
    static func getEmail() -> String {
        return userDefault.value(forKey: "dentistEmail") as? String ?? ""
    }
    
    static func setSyndicateID(syndicateID:String?){
        userDefault.set(syndicateID ,forKey: "syndicateID")
    }
    static func getSyndicateID() -> String {
        return userDefault.value(forKey: "syndicateID") as? String ?? ""
    }
    
    static func setDentistQualifications(userQualifications:String?){
        userDefault.set(userQualifications ,forKey: "userQualifications")
    }
    static func getDentistQualifications() -> String {
        return userDefault.value(forKey: "userQualifications") as? String ?? ""
    }
    
    static func setDentistUuid(userQualifications:String?){
        userDefault.set(userQualifications ,forKey: "dentistUuid")
    }
    static func getDentistUuid() -> String {
        return userDefault.value(forKey: "dentistUuid") as? String ?? ""
    }
    
    static func setFirstvisit(firistVisit:Int?){
        userDefault.set(firistVisit ,forKey: "firistVisit")
    }
    static func getFirstvisit() -> Int {
        return userDefault.value(forKey: "firistVisit") as? Int ?? 0
    }
    
    static func setConsultation(consultation:Int?){
        userDefault.set(consultation ,forKey: "consultation")
    }
    static func getConsultation() -> Int {
        return userDefault.value(forKey: "consultation") as? Int ?? 0
    }
    
    static func setRepeatVisit(repeatVisit:Int?){
        userDefault.set(repeatVisit ,forKey: "repeatVisit")
    }
    static func getRepeatVisit() -> Int {
        return userDefault.value(forKey: "repeatVisit") as? Int ?? 0
    }
    
    class func openLoginVC()
    {
        let storyboard = currentStoryboard(.Login)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigation")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(loginNavController)
    }
    
    class func openHomeVC()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MyTabBarCtrl") as! MyTabBarCtrl
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainTabBarController)
    }
}
