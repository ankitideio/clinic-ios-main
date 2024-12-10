//
//  CommonUtilites.swift
//  lnkr-clinic
//
//  Created by meet sharma on 27/04/23.
//


import Foundation
import UIKit
import SwiftMessages
class CommonUtilities{
    static let shared = CommonUtilities()
    
    func showAlert(message :String){
        DispatchQueue.main.async
        {
            let alert = UIAlertController(title:"", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                }
                
                
            })
            
            alert.addAction(ok)
            
            DispatchQueue.main.async {
                //if let window = UIApplication.shared.keyWindow
                if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
                    DispatchQueue.main.async {
                        
                        window.rootViewController!.present(alert, animated: true)
                    }
                }
            }
        }
    }
   
    func showAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?])
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated()
        {
            if title == NSLocalizedString("Cancel", comment: appName)
            {
                let action = UIAlertAction(title: title, style: .cancel, handler: actions[index])
                alert.addAction(action)
            }
            else
            {
                let action = UIAlertAction(title: title, style: .default, handler: actions[index])
                alert.addAction(action)
            }
        }
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
                DispatchQueue.main.async {
                    window.rootViewController!.present(alert, animated: true)
                    
                }
            }
        }
        
    }
    
}
//MARK: POP ON CLICK OF ALERT MESSAGE
func showAlertWithSingleActionPopVC(sender:UIViewController,message:String = "")  {
    let alertController = UIAlertController(title: appName, message: message, preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        sender.navigationController?.popViewController(animated: true)
    }
    
    alertController.addAction(okAction)
    sender.present(alertController, animated: true, completion: nil)
}

//MARK: SHOW ALERT
func showAlertWithSingleAction(value: Bool,sender:UIViewController,message:String = "")  {
    let alertController = UIAlertController(title: appName, message: message, preferredStyle: .alert)
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
       
    }
    alertController.addAction(okAction)
    sender.present(alertController, animated: true, completion: nil)
}

func showSwiftyAlert(_ Title :String,_ body: String ,_ isSuccess : Bool){
    DispatchQueue.main.async {
        let warning = MessageView.viewFromNib(layout: .cardView)
        if isSuccess == true{
            warning.configureTheme(.success)
        }else{
            warning.configureTheme(.error)
        }
        warning.configureDropShadow()
        warning.configureContent(title: Title, body: body)
        warning.button?.isHidden = true
        // warning.iconImageView?.image = #imageLiteral(resourceName: "imgNavLogo")
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        warningConfig.duration = .seconds(seconds: 3)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
