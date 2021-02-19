//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Carlos on 18/02/21.
//

import Foundation

extension Date {
    
    func convertToMothYearFormat() -> String{
        let dateFormatter         = DateFormatter()
        dateFormatter.dateFormat  = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    
}
