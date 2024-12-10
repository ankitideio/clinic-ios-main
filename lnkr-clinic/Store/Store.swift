//
//  Store.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//

import Foundation


class Store {
    //MARK: - STORE DATA
    class var patientId: Int?{
        set{
            Store.saveValue(newValue, .patientId)
        }
        get{
            return Store.getValue(.patientId) as? Int
        }
    }
    class var patientName: String?{
        set{
            Store.saveValue(newValue, .patientName)
        }
        get{
            return Store.getValue(.patientName) as? String
        }
    }
    class var isSearch: Bool?{
        set{
            Store.saveValue(newValue, .isSearch)
        }
        get{
            return Store.getValue(.isSearch) as? Bool ?? false
        }
    }
    //MARK: -  Private Functions
    private class func saveValue(_ value: Any? ,_ key:DefaultKeys){
        var data: Data?
        if let value = value{
            data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
        }
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
 
    
    private class func getValue(_ key: DefaultKeys) -> Any{
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
            if let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            {
                return value
            }
            else{
                return ""
            }
        }else{
            return ""
        }
    }
}
