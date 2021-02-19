//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Carlos on 07/12/20.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async{
            let alert = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true)
        }
    }
    
    func showLoadinView(){
        containerView                  = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor  = .systemBackground
        containerView.alpha            = 0
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyState(){
        DispatchQueue.main.async {
            let emptyStateView = GFEmptyState(message: "This user doesn't have any followers. 👌😫")
            emptyStateView.frame = self.view.frame
            self.view.addSubview(emptyStateView)
        }
    }
    
    func presentSafariVC(url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        present(safariVC, animated: true)
    }
    
}
