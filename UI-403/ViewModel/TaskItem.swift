//
//  TaskItem.swift
//  UI-403
//
//  Created by nyannyan0328 on 2021/12/26.
//

import SwiftUI
import RealmSwift

class TaskItem: Object,Identifiable {
    
    @Persisted(primaryKey: true) var id : ObjectId
    
    @Persisted var taskTitle : String
    @Persisted var taskDate : Date = Date()
    @Persisted var taskStatus : TaskStaus = .pending
   
}

enum TaskStaus : String,PersistableEnum{
    
    case missed = "Missed"
    case completed = "Completed"
    case pending = "Pending"
}

