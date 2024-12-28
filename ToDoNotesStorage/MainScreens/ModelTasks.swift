//
//  ModelTasks.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 25.12.2024.
//

// Task.swift
import Foundation

// Структура для задачи
struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var date: Date
    var time: Date
    var userEmail: String
    var isCompleted: Bool = false
    
    init(id: UUID, title: String, description: String, date: Date, time: Date, userEmail: String, isCompleted: Bool = false) {
         self.id = UUID()
         self.title = title
         self.description = description
         self.date = date
         self.time = time
         self.userEmail = userEmail
        self.isCompleted = isCompleted
        
     }
}



// Форматтер для даты
let taskDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

// Форматтер для времени
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()
