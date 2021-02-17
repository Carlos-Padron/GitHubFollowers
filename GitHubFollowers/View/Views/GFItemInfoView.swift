//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Carlos on 16/02/21.
//

import UIKit

class GFItemInfoView: UIView {

    let symbolImageView  = UIImageView()
    let titleLabel       = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel       = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
