//
//  FollowerListVCViewController.swift
//  GitHubFollowers
//
//  Created by Carlos on 05/12/20.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Sections{
        case main
    }

    var collectionView: UICollectionView!
    var username: String!
    var dataSource: UICollectionViewDiffableDataSource<Sections, Follower>!
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func configureViewController(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnsFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func createThreeColumnsFlowLayout()-> UICollectionViewFlowLayout{
        
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
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { (result) in
            
            switch result{
            case .success(let followers):
                print(followers.count)
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Sections, Follower>(collectionView: collectionView, cellProvider: { (collection, indexPath, follower) -> UICollectionViewCell? in
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }

    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
