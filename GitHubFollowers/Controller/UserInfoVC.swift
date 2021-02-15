//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 11/02/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var headerView = UIView()
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        layOutUI()
        getUserInfo(user: username)
        
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    func getUserInfo(user: String){
        NetworkManager.shared.getUserInfo(username: user) { [weak self] (result) in
            
            guard let self = self else {return}
            
            switch result{
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.add(childVC: UserInfotHeaderVC(user: user), to: self.headerView)
                }
                
                    break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happended", message: error.rawValue, buttonTitle: "Ok 😫👌")
            
            }
        }
    }
    
    
    func layOutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    func add(childVC: UIViewController, to contianerView: UIView){
        addChild(childVC)
        contianerView.addSubview(childVC.view)
        childVC.view.frame = contianerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
