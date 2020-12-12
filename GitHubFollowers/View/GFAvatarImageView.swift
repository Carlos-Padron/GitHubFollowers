//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Carlos on 12/12/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

 let placeholder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        layer.cornerRadius = 10
        image              = placeholder
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = true
    }
    
}
