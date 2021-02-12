//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Carlos on 09/12/20.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessages>) ->Void){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        print(endPoint)
        guard let url = URL(string: endPoint) else{
            return completed(.failure(.invalidUsername))
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completed(.failure(.invalidResponse))
            }
            
            guard let data = data else{
                return completed(.failure(.invalidData))
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
            
            

        }
    
        task.resume()
    }
    
    func getUserInfo(username: String, completed: @escaping ( Result<User,ErrorMessages>)->Void ){
        
        let endPoint = baseURL + "\(username)"
    print(endPoint)
        guard let url = URL(string: endPoint) else{
            return completed(.failure(.invalidUsername))
        }
       
        
        let request =  URLSession.shared.dataTask(with: url) { (data, httpResponse, error) in
            if let _ = error{
                return completed(.failure(.unableToComplete))
            }
            
            guard let response = httpResponse as? HTTPURLResponse, response.statusCode == 200 else{
                return completed(.failure(.invalidResponse))
            }
            
            guard let data = data else{
                
                return completed(.failure(.invalidResponse))
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let user = try jsonDecoder.decode(User.self, from: data)
                completed(.success(user))
            }catch {
                print(error)
                return completed(.failure(.invalidResponse))
            }
        }
        
        request.resume()
    
    
    }
    
}
