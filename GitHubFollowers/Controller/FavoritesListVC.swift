//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Carlos on 02/12/20.
//

import UIKit

class FavoritesListVC: UIViewController{

    var tableView: UITableView!
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        getFavorites()
        
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 80
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }

    func getFavorites(){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                print(followers)
                if followers.isEmpty {
                    self.showEmptyState()
                }else{
                    self.favorites = followers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong :(", message: error.rawValue, buttonTitle: ":(")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let follower = favorites[indexPath.row]
        
        let destVC = FollowerListVC()
        destVC.username = follower.login
        destVC.title    = follower.login
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let follower = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(follower: follower, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            
            self.presentGFAlertOnMainThread(title: "Error :(", message: error.rawValue, buttonTitle: "ok :(")
        }
        
    }
    
    
    

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as? FavoriteCell {
            let favorite = favorites[indexPath.row]
            cell.set(favorite: favorite)
            return cell
        }
        return UITableViewCell()
        
    }
    
    
}
