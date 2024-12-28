//
//  TaskDetail.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 27.12.2024.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    var task: Task
    
    @Environment(\.presentationMode) var presentationMode // Для закрытия экрана
    
    var body: some View {
        ZStack {
            Image(.gradient)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(task.title)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 40)
                        .padding(.leading, 37)
                    
                    Image(.pencilSquare)
                        .padding(.top, 38)
                }
                
                HStack {
                    HStack {
                        Image(.iconCalendar)
                            .padding(.leading, 37)
                        Text("\(task.date, formatter: taskDateFormatter)")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.9))
                    }
                    
                    Text("|")
                        .foregroundStyle(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.9))
                        .padding(.bottom, 4)
                    
                    HStack {
                        Image(.iconClock)
                        Text("\(task.time, formatter: timeFormatter)")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.9))
                    }
                }
                
                Divider()
                    .background(Color.white)
                    .padding(.leading, 37)
                    .padding(.trailing, 40)
                    .padding([.top, .bottom], 25)
                
                ScrollView {
                    Text(task.description)
                        .font(.system(size: 14))
                        .padding(.leading, 37)
                        .padding(.trailing, 40)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .lineSpacing(2)
                    
                    // Используем Spacer только в HStack для центровки кнопок
                    HStack {
                        Spacer()
                        
                        ZStack {
                            // Кнопка "Выполнить"
                            Button(action: {
                                taskViewModel.markTaskAsCompleted(task)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Done")
                                    .padding(.top, 30)
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .frame(width: 90, height: 70)
                                    .background((Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255, opacity: 1)))
                                    .cornerRadius(12)
                                    .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            Image(.checkCircle)
                                .padding(.bottom, 35)
                        }
                        
                        Spacer().frame(width: 70) // Задает расстояние между кнопками
                        
                        ZStack {
                            // Кнопка "Удалить"
                            Button(action: {
                                taskViewModel.deleteTask(task)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Delete")
                                    .padding(.top, 30)
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .frame(width: 90, height: 70)
                                    .background((Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255, opacity: 1)))
                                    .cornerRadius(12)
                                    .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            Image(.iconDelete)
                                .padding(.bottom, 35)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 60)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true) 
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss() // Действие для кнопки назад
        }) {
            HStack {
                Image(.arrowBack)
                    .foregroundColor(.white)
                Text("Task Details")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TaskDetailView(
        taskViewModel: TaskViewModel(userEmail: "test@example.com"),
        task: Task(
            id: UUID(),
            title: "Test Task",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            date: Date(),
            time: Date(),
            userEmail: "email"
        )
    )
}
