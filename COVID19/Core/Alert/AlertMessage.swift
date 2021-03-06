//
//  AlertMessage.swift
//  COVID19
//
//  Created by Mohamed Shemy on Thu 12 Aug 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

enum AlertMessage
{
    // MARK:- Cases
    
    case noResult(String)
    case noReports(String)
    
    case unkown(String)
    
    // MARK:- init
    
    init(_ message: String)
    {
        self = .unkown(message)
    }
        
    // MARK:- Values
    
    var value: String
    {
        switch self
        {
            case let .noResult(key): return "No result matches: \(key)"
            case let .noReports(date): return "No reports in \(date)"
                
            case let .unkown(message): return message
        }
    }
}
