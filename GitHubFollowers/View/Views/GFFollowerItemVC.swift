//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 17/02/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func onTap() {
        delegate.didTapGetFollowers(for: user)
    }
    
}
