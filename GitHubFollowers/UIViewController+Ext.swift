//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Carlos on 07/12/20.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async{
            let alert = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true)
        }
    }
}
