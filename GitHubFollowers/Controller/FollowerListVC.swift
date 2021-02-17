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
    var isSearching = false
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnsFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func configureSearchController(){
        let searchController                   = UISearchController()
        searchController.searchResultsUpdater  = self
        searchController.searchBar.delegate    = self
        searchController.searchBar.placeholder = "Search for someone 😮"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController        = searchController
        
    }
    
    func getFollowers(username: String, page: Int){
        showLoadinView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self](result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result{
            
            case .success(let followers):
                print(followers.count)
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    self.showEmptyState()
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happended", message: error.rawValue, buttonTitle: "Ok")
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

    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}

extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yOffset        = scrollView.contentOffset.y
        let contentHeight  = scrollView.contentSize.height
        let height         = scrollView.frame.height
        
        if yOffset > contentHeight - height {
            guard hasMoreFollowers else{ return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower =  activeArray[indexPath.item]
        
        let destVC = GFUserInfoVC()
        destVC.username = follower.login
        
        let navCtrl = UINavigationController(rootViewController: destVC)
        present(navCtrl, animated: true)
        
        
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            updateData(on: followers)
            return
        }
        isSearching = true
        filteredFollowers =  followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
}
