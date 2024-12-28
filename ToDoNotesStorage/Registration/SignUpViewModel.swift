//
//  SignUpViewModel.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 22.12.2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet {
            isValidEmail = validateEmail()  // Проверка при каждом изменении email
        }
    }
    
    
    
    
    @Published var password: String = ""
    @Published var fullName: String = ""
    @Published var isValidEmail: Bool = true // Новое свойство для отслеживания валидности email
    @Published var showAlert: Bool = false
    @Published var alertMessage = ""
    
    // Функция для валидации всех данных
    func isValidForm() -> Bool {
        if fullName.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "All fields must be filled."
            showAlert = true
            return false
        }
        if !isValidEmail {
            alertMessage = "Invalid email format."
            showAlert = true
            return false
        }
        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters."
            showAlert = true
            return false
        }
        return true
    }
    
    func defaults() {
        // Сохраняем данные пользователя в UserDefaults по ключу, основанном на email
        UserDefaults.standard.set(password, forKey: "password_\(email)")
        UserDefaults.standard.set(fullName, forKey: "fullname_\(email)")
        print("User data saved: \(email), \(password), \(fullName)")
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
}

