//
//  Date.swift
//  App ToDoList
//
//  Created by Felipe Santos on 27/11/23.
//

import Foundation

extension Date {
    public func convertDateToString(date: Date, dateFormatter: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        
        formatter.dateFormat = dateFormatter ?? "yyyy-MM-dd'T'HH:mm:ss"
        guard let yourDate else { return "" }
        return formatter.string(from: yourDate)
    }
    
    public func convertStringToDate(dataString: String, dataFormatter: String?) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dataFormatter ?? "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.date(from: dataString)
    }
    
}
