//
//  SignInViewModel.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 22.12.2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    @Published var alertMessage: String = ""
    @Published var navigateToHome: Bool = false
    @Published var showAlert: Bool = false
    
    // Функция для загрузки данных из UserDefaults
    func loadDefaults() {
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        password = UserDefaults.standard.string(forKey: "password") ?? ""
        fullName = UserDefaults.standard.string(forKey: "fullname") ?? ""
        print("Loaded user data: email=\(email), password=\(password), fullName=\(fullName)")
    }
    
    func signIn() {
        // Проверка на наличие данных для пользователя по email
        let storedPassword = UserDefaults.standard.string(forKey: "password_\(email)")
        let storedFullName = UserDefaults.standard.string(forKey: "fullname_\(email)")
        
        if let storedPassword = storedPassword, storedPassword == password {
            // Если данные корректны, обновляем fullName и email
            fullName = storedFullName ?? "Unknown"
            navigateToHome = true
        } else {
            showAlert = true
            alertMessage = "Invalid email or password."
        }
    }
}
