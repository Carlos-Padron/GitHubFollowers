//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 11/02/21.
//

import UIKit

class GFUserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
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
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                }
                    break
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happended", message: error.rawValue, buttonTitle: "Ok 😫👌")
            
            }
        }
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    
    func layOutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
        }
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    func add(childVC: UIViewController, to contianerView: UIView){
        addChild(childVC)
        contianerView.addSubview(childVC.view)
        childVC.view.frame = contianerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
