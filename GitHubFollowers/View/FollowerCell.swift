//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Carlos on 12/12/20.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID      = "FollowerCell"
           let avatarImage  = GFAvatarImageView(frame: .zero)
           let username     = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Follower){
        self.username.text = follower.login
    }
    
    func configure(){
        let padding: CGFloat = 8
        
        addSubview(avatarImage)
        addSubview(username)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            username.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            username.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            username.heightAnchor.constraint(equalToConstant: 20)
        ])
            
    }
    
}
