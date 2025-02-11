//
//  String+Extensions.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/11/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
