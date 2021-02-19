//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 11/02/21.
//

import UIKit


protocol userInfonVCDelegate {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}


class GFUserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    
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
                self.configureUIElements(with: user)
                    break
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happended", message: error.rawValue, buttonTitle: "Ok 😫👌")
            
            }
        }
    }
    
    func configureUIElements(with user: User){
        let repoItemVC             = GFRepoItemVC(user: user)
        repoItemVC.delegate        = self
        
        let followersItemVC        = GFRepoItemVC(user: user)
        followersItemVC.delegate   = self
        
        DispatchQueue.main.async {
            self.add(childVC: UserInfotHeaderVC(user: user), to: self.headerView)
            self.add(childVC: repoItemVC, to: self.itemViewOne)
            self.add(childVC: followersItemVC, to: self.itemViewTwo)
            self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayedFormat())"
        }
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    
    func layOutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 	18)
        ])
    }
    
    
    func add(childVC: UIViewController, to contianerView: UIView){
        addChild(childVC)
        contianerView.addSubview(childVC.view)
        childVC.view.frame = contianerView.bounds
        childVC.didMove(toParent: self)
    }
    
}

extension GFUserInfoVC: userInfonVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
                presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok 😭")
            return
        }
      presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(for user: User) {
        
    }
    
   
    
    
}
