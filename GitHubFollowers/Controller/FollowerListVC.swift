//
//  FollowerListVCViewController.swift
//  GitHubFollowers
//
//  Created by Carlos on 05/12/20.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else{
                
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
           
            
            print(followers.count)
        }
        // Do any additional setup after loading the view.
    }
    

}
