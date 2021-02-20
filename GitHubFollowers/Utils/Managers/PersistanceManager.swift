//
//  PersistanceManager.swift
//  GitHubFollowers
//
//  Created by Carlos on 20/02/21.
//

import Foundation

enum PersistanceActionType{
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(follower: Follower, actionType: PersistanceActionType, completed: @escaping(ErrorMessages?) -> Void){
        
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                var retrievedFollowers = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFollowers.contains(follower) else {
                        completed(.alreadyiIFavorites)
                        return
                    }
                    retrievedFollowers.append(follower)
                    
                case .remove:
                    retrievedFollowers.removeAll{ $0.login == follower.login}
                    
                }
                
                completed(save(favorites: retrievedFollowers))
            
            case .failure(let error):
                completed(error)
            }
        }
        
        
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], ErrorMessages>) -> Void){
        guard let followersData = defaults.object(forKey: Keys.favorites) as? Data else {
             completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: followersData)
            completed(.success(favorites))
        } catch  {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> ErrorMessages? {
        do {
            let encoder =  JSONEncoder()
            let encodedFollowers = try encoder.encode(favorites)
            defaults.setValue(encodedFollowers, forKey: Keys.favorites)
            return nil
        } catch  {
            return .unableToFavorite
        }
    }
    
    
}
