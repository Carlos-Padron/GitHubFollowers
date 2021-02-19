//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 17/02/21.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView        = UIStackView()
    let itemInfoViewOne  = GFItemInfoView()
    let itemInfoViewTwo  = GFItemInfoView()
    let actionButton     = GFButton()
    
    weak var delegate: userInfonVCDelegate!
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user =  user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        attachActionToButton()
        layOutUI()
        configureStackView()
        // Do any additional setup after loading the view.
    }
    
    private func attachActionToButton(){
        actionButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    @objc func onTap(){}
    
    private func configureBackgroundView(){
        view.backgroundColor     = .secondarySystemBackground
        view.layer.cornerRadius  = 18
    }
    
    private func layOutUI(){
        let padding: CGFloat =  20
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints    = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
    private func configureStackView(){
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }

}
