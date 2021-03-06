//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Carlos on 18/02/21.
//

import Foundation

extension String{
    func convertToDate() -> Date? {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat     = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale         = Locale(identifier: "es_MX")
        dateFormatter.timeZone       = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayedFormat() -> String{
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMothYearFormat()
    }
}
