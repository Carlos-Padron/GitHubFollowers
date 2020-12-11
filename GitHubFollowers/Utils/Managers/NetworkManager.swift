//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Carlos on 09/12/20.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String? ) ->Void){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        print(endPoint)
        guard let url = URL(string: endPoint) else{
            return completed(nil, "This username created an invalid request :(")
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return completed(nil, "Unable to complete your request. Please check your internet connection")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completed(nil, "Invalid response from the server :(")
            }
            
            guard let data = data else{
                return completed(nil, "The data received from the server was invalid :(")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, "The data received from the server was invalid")
            }
            
            

        }
    
        task.resume()
    }
    
}
