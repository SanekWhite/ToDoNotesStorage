//
//  HomePage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 23.12.2024.
//

import SwiftUI

struct ScreenHomePage: View {
    @Binding var email: String
    @Binding var fullName: String
    @StateObject private var signInViewModel: SignInViewModel
    @StateObject private var taskViewModel: TaskViewModel
    @StateObject private var viewModelSetting: ViewModelSetting
    @State private var showPopup: Bool = false
    
    init(email: Binding<String>, fullName: Binding<String>) {
        _email = email
        _fullName = fullName
        _signInViewModel = StateObject(wrappedValue: SignInViewModel())
        _viewModelSetting = StateObject(wrappedValue: ViewModelSetting())
        _taskViewModel = StateObject(wrappedValue: TaskViewModel(userEmail: email.wrappedValue)) // Инициализация с email
    }
    
    var body: some View {
        
        TabView {
            ZStack {
                Image(.gradient)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("\(fullName)")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding(.top, 26)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    HStack {
                        Text("\(email)")
                            .foregroundStyle(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.5))
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Incomplete Tasks")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(.top, 70)
                            .padding(.bottom, 10)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    List(taskViewModel.tasks.filter { !$0.isCompleted }) { task in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(task.title)
                                    .font(.headline)
                                Spacer()
                            }
                            Text("\(task.date, formatter: taskDateFormatter) | \(task.time, formatter: timeFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(7)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .listRowBackground(Color.clear)
                        
                        .background(Color.white)
                        .cornerRadius(5)
                        
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    
                    HStack {
                        Text("Completed Tasks")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    List(taskViewModel.tasks.filter { $0.isCompleted }) { task in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.green)
                                
                                Text(task.title)
                                    .font(.headline)
                                    .strikethrough()
                                Spacer()
                            }
                            
                            Text("\(task.date, formatter: taskDateFormatter) | \(task.time, formatter: timeFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        .padding(7)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .listRowBackground(Color.clear)
                        
                        .background(Color.white)
                        .cornerRadius(5)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            
            TasksPage(signInViewModel: signInViewModel, showPopup: $showPopup, taskViewModel: taskViewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            
            CalendarPage(taskViewModel: taskViewModel)
                .tabItem {
                    Image(systemName: "calendar")
                }
            
            SettingPage(viewModelSetting: viewModelSetting)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .navigationBarBackButtonHidden(true) 
        .onAppear {
            taskViewModel.loadTasks(for: email)
        }
        .overlay(
            Group {
                if showPopup {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        
                        PopupView(
                            signInViewModel: signInViewModel,
                            taskViewModel: taskViewModel,
                            showPopup: $showPopup,
                            tasks: $taskViewModel.tasks
                        )
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                    }
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                        }
                    }
                }
            }
        )
    }
}

#Preview {
    ScreenHomePage(email: .constant("simple@mail.ru"), fullName: .constant("Cat Black"))
}
