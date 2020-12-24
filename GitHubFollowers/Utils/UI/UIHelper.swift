//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Carlos on 23/12/20.
//

import UIKit

struct UIHelper {
    
    
    static func createThreeColumnsFlowLayout(in view: UIView)-> UICollectionViewFlowLayout{
        
        let width                        = view.bounds.width
        let padding: CGFloat             = 12
        let mimimunItemSpacing: CGFloat  = 10
        let availableWidth               = width - (padding * 2) - (mimimunItemSpacing * 2)
        let itemWidth                    = availableWidth / 3
        
        let flowLayout                   = UICollectionViewFlowLayout()
        flowLayout.sectionInset          = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize              = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
