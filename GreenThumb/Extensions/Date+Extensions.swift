//
//  Date+Extensions.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import Foundation

extension Date {
    
    func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: self) ?? self 
    }
    
}
