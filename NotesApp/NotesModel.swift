//
//  NotesModel.swift
//  NotesApp
//
//  Created by apple on 04/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import CoreData

class NotesModel{
    var title : String = ""
    var description : String = ""
    var timeStamp : Int = 0
    var imageData : Data = Data()
    
    init(data:NSManagedObject) {
        self.title = data.value(forKey: "title") as? String ?? ""
        self.description = data.value(forKey: "descript") as? String ?? ""
        self.timeStamp = data.value(forKey: "timestamp") as? Int ?? 0
        self.imageData = data.value(forKey: "image") as? Data ?? Data()
    }
}
