//
//  TaskViewModel.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 25.12.2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var userEmail: String

    init(userEmail: String) {
        self.userEmail = userEmail
        loadTasks(for: userEmail)
    }

    
    
    func loadTasks(for userEmail: String) {
        self.tasks = TaskManager.shared.loadTasks(for: userEmail) // Загружаем задачи для этого пользователя
    }

    func addTask(_ task: Task) {
        tasks.append(task)
        TaskManager.shared.addTask(task, for: userEmail)
        loadTasks(for: userEmail) // Обновляем список задач после добавления
    }
    
    /// Помечает задачу как выполненную
     func markTaskAsCompleted(_ task: Task) {
         if let index = tasks.firstIndex(where: { $0.id == task.id }) {
             tasks[index].isCompleted = true
             TaskManager.shared.updateTask(tasks[index]) // Сохраняем изменения
         }
         loadTasks(for: userEmail) // Обновляем список задач
     }

     /// Удаляет задачу
     func deleteTask(_ task: Task) {
         tasks.removeAll { $0.id == task.id }
         TaskManager.shared.deleteTask(task, for: userEmail) // Удаляем из хранилища
         loadTasks(for: userEmail) // Обновляем список задач
     }
}
