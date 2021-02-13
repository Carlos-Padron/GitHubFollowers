//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 11/02/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        
        getUserInfo(user: username)
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    func getUserInfo(user: String){
        
        
        NetworkManager.shared.getUserInfo(username: user) { [weak self] (result) in
            switch result{
            case .success(let user):
                print(user)
                    break
            case .failure(let error):
                self?.presentGFAlertOnMainThread(title: "Bad stuff happended", message: error.rawValue, buttonTitle: "Ok 😫👌")
            
            }
        }
        
    }
    
}
