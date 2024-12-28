//
//  CalendarPage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 23.12.2024.
//

import SwiftUI
import FSCalendar

struct CalendarPage: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var selectedDate: Date = Date()
    @State private var tasksForSelectedDate: [Task] = []
    

    var body: some View {
        
        ZStack {
            Image(.gradient)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Calendar")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(.top, 30)
                
                
                CalendarView(selectedDate: $selectedDate, tasks: taskViewModel.tasks)
                    .frame(height: 300)
                    .background(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.2))
                    .cornerRadius(12)
                    .padding([.top, .bottom], 40)
                    .padding([.leading, .trailing], 20)
                
                
                
                if tasksForSelectedDate.isEmpty {
                    Text("No tasks for this day.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(tasksForSelectedDate) { task in
                              
                                NavigationLink(destination: TaskDetailView(taskViewModel: taskViewModel, task: task)) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(task.title)
                                                .font(.headline)
                                            Spacer()
                                        }
                                        Text("\(task.date, formatter: taskDateFormatter) | \(task.time, formatter: timeFormatter)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(7)
                                    .frame(maxWidth: .infinity)
                              
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                                .background(Color.clear)
                            }
                    
                            .padding([.leading, .trailing], 20)
                    
                            .listStyle(PlainListStyle())
                           
                        }
                
                  
                Spacer()
            }
            .onChange(of: selectedDate) {
                tasksForSelectedDate = taskViewModel.tasks.filter {
                    Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
                }
            }
            .onAppear {
                tasksForSelectedDate = taskViewModel.tasks.filter {
                    Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
                }
            }
        }
    }
    
}







#Preview {
    let email = "sad@mail.ru"
    let mockTasks = [
        Task(
            id: UUID(),
            title: "Купить продукты",
            description: "молоко, хлеб, масло",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            time: Date(),
            userEmail: email
        ),
        Task(
            id: UUID(),
            title: "новый год",
            description: "новый год",
            date: Date(),
            time: Date(),
            userEmail: email
        ),
        Task(
            id: UUID(),
            title: "закончить проект",
            description: "закончить проект",
            date: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
            time: Date(),
            userEmail: email
        )
    ]
    
    let mockTaskViewModel = TaskViewModel(userEmail: email)
    mockTaskViewModel.tasks = mockTasks
    
    return CalendarPage(taskViewModel: mockTaskViewModel)
}
