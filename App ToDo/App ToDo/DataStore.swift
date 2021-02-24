//
//  File.swift
//  App ToDo
//
//  Created by AndyZett on 16/02/21.
//



// Untuk menyimpan data tasks.


import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
    
    
    
    
    
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
