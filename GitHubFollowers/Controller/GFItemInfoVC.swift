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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layOutUI()
        configureStackView()
        // Do any additional setup after loading the view.
    }
    
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
            stackView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 44),
            
        ])
    }
    
    private func configureStackView(){
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }

}
