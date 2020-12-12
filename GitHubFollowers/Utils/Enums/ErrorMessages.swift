//
//  ErrorMessages.swift
//  GitHubFollowers
//
//  Created by Carlos on 11/12/20.
//

import Foundation

enum ErrorMessages: String, Error {
    case invalidUsername  = "This username created an invalid request :("
    case unableToComplete = "Unable to complete your request. Please check your internet connection :("
    case invalidResponse  = "Invalid response from the server :("
    case invalidData      = "The data received from the server was invalid :("
}
