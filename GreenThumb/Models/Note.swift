//
//  Note.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var body: String
    var dateCreated: Date
    @Attribute(.externalStorage) var photo: Data? = nil
    
    var myGardenVegetable: MyGardenVegetable?
    
    init(title: String, body: String, dateCreated: Date = Date()) {
        self.title = title
        self.body = body
        self.dateCreated = dateCreated
    }
}
