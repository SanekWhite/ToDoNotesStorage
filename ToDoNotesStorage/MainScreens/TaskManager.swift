//
//  TaskManager.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 25.12.2024.
//

import Foundation

class TaskManager {
    
    init() {
        loadTasksFromStorage()
    }
    
    static let shared = TaskManager() // Singleton, чтобы получить доступ отовсюду
    
    private var tasks: [String: [Task]] = [:] // Словарь с задачами по email

    func loadTasks(for userEmail: String) -> [Task] {
        return tasks[userEmail] ?? [] // Возвращаем задачи для конкретного пользователя
    }

    func addTask(_ task: Task, for userEmail: String) {
        if tasks[userEmail] == nil {
            tasks[userEmail] = [] // Если для пользователя нет задач, создаем новый массив
        }
        tasks[userEmail]?.append(task) // Добавляем задачу в массив для данного пользователя
        saveTasks()
    }
    
    /// Обновляет задачу
     func updateTask(_ task: Task) {
         for (email, taskList) in tasks {
             if let index = taskList.firstIndex(where: { $0.id == task.id }) {
                 tasks[email]?[index] = task // Обновляем задачу, если нашли
                 saveTasks()
             }
         }
     }

    func deleteTask(_ task: Task, for userEmail: String) {
          tasks[userEmail]?.removeAll { $0.id == task.id } // Удаляем задачу по id
        saveTasks()
      }
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    func loadTasksFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([String: [Task]].self, from: data) {
            tasks = decoded
        }
    }
}
