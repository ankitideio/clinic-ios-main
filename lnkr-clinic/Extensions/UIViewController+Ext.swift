//
//  UIViewController+Ext.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 13 Heshvan 5783.
//

import UIKit
import MBProgressHUD

extension UIViewController{
    
    
    static func showToast(controller: UIViewController, message: String, seconds: Double){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 0.8)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 20)!,NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 138.0/255.0, alpha: 1.0)]
        let titleString = NSAttributedString(string: message, attributes: titleAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    static func presentAlert(controller: UIViewController,title:String, message: String,style:UIAlertController.Style,actionTitle:String,action:@escaping (_ action:UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle:style )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: action))
         controller.present(alert, animated: true, completion: nil)
        
        
    }
    
    func showLoadingView(){
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = "loading Content..."
        Indicator.isUserInteractionEnabled = false
        Indicator.show(animated: true)
    }
    
    func hideLoadingView(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func calculateBMI(weight: Double, height: Double) -> Double {
        let bmi = weight / (height * height)
        return bmi
    }
    
    func convertCmToM(_ cm: Double) -> Double {
        let m = cm / 100.0
        return m
    }
    
    func convertMToCm(_ m: Double) -> Double {
        let cm = m * 100.0
        return cm
    }
    func formatDouble(_ num: Double) -> String {
        let formattedNum = String(format: "%.2f", num)
        return formattedNum
    }
}



extension UIViewController {
func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        navBarAppearance.backgroundColor = backgoundColor

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
        
        

    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func removingOccurrences(of stringToRemove: String) -> String {
        return self.replacingOccurrences(of: stringToRemove, with: "")
    } // removingOccurrences
}
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

