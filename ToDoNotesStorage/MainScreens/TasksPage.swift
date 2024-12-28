//
//  TasksPage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 23.12.2024.
//


import SwiftUI

struct TasksPage: View {
    @ObservedObject var signInViewModel: SignInViewModel
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var showPopup: Bool
    @State private var searchText: String = ""
    
    init(signInViewModel: SignInViewModel, showPopup: Binding<Bool>, taskViewModel: TaskViewModel) {
        self.signInViewModel = signInViewModel
        self._taskViewModel = ObservedObject(wrappedValue: taskViewModel) // Используем переданный taskViewModel
        self._showPopup = showPopup
    }
    
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return taskViewModel.tasks
        } else {
            return taskViewModel.tasks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            Image(.gradient)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    CustomTextView(
                        text: $searchText,
                        backgroundColor: UIColor(red: 16 / 255, green: 45 / 255, blue: 83 / 255, alpha: 0.8),
                        textColor: .white,
                        cornerRadius: 10,
                        padding: 10
                    )
                 
                    .frame(maxWidth: .infinity, maxHeight: 42)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Search by task title")
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.gray)
                            .padding(.top, 40)
                            .padding(.leading, 35)
                            .opacity(searchText.isEmpty ? 1 : 0)
                        
                        Spacer()
                    Image(systemName: "magnifyingglass")
                        .frame(width: 17, height: 17)
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                        .padding(.trailing, 30)
                        .padding(.top, 40)
                        .opacity(searchText.isEmpty ? 1 : 0)
                       
                    }
                   
                }
                
                HStack {
                    Text("Tasks List")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 16))
                        .padding(.top, 40)
                        .padding(.leading, 20)
                    Spacer()
                }
                
                
                // Список задач
                NavigationView {
                    List(filteredTasks) { task in
                        NavigationLink(destination: TaskDetailView(taskViewModel: taskViewModel, task: task)) {
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
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(Color.clear)
                    }
                    .padding([.leading, .trailing], 20)
                    .listStyle(PlainListStyle())
                
                            
                            
                            
                        
                        
                  
                        
                        
                    
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .navigationBarHidden(true)
                    
                    .background(Image(.gradientList).resizable().edgesIgnoringSafeArea(.all))
                    
                    
                }
                
                
                .cornerRadius(12)
                .padding([.top, .bottom], 20)
              //  .padding([.leading, .trailing], 20)
                
                Spacer()
                
                // Кнопка для открытия попапа с созданием новой задачи
                Button(action: {
                    withAnimation {
                        showPopup.toggle() // Открыть всплывающее окно
                    }
                }) {
                    HStack {
                        Spacer()
                        ZStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.cyan)
                                .padding(.bottom, 45)
                                .padding(.trailing, 30)
                            Image(.vector)
                                .resizable()
                                .frame(width: 17, height: 17)
                                .padding(.bottom, 45)
                                .padding(.trailing, 30)
                        }
                    }
                }
                
                
            }
        }
        
    }
    
}



// Попап с созданием задачи
struct PopupView: View {
    @ObservedObject var signInViewModel: SignInViewModel
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var showPopup: Bool
    @State private var taskDescription: String = ""
    @State private var titleTasks: String = "Task"
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var showDatePicker: Bool = false
    @State private var showTimePicker: Bool = false
    @Binding var tasks: [Task]
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    VStack {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            TextField("Task title", text: $titleTasks)
                                .foregroundColor(.white)
                                .textInputAutocapitalization(.none)
                                .padding(.vertical, 12)
                                .padding(.leading, 0)
                                .background(Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255, opacity: 1))
                                .cornerRadius(8)
                                .frame(height: 50)
                        }
                        .background(Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255, opacity: 1))
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 27)
                        .padding(.top, 54)
                    }
                    
                    ZStack(alignment: .leading) {
                        // TextEditor для описания задачи
                        CustomTextView(
                            text: $taskDescription,
                            backgroundColor: UIColor(red: 5 / 255, green: 36 / 255, blue: 62 / 255, alpha: 1),
                            textColor: .white,
                            cornerRadius: 8,
                            padding: 10
                        )
                        .frame(height: 160)
                        .padding([.leading, .trailing], 27)
                        .padding(.top, 34)
                        
                        // Иконка и текст "Description" внутри TextEditor
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .padding(.leading, 38)
                                .padding(.bottom, 80)
                                .opacity(taskDescription.isEmpty ? 1 : 0)
                            
                            Text("Description")
                                .foregroundColor(.white)
                                .padding(.bottom, 80)
                                .opacity(taskDescription.isEmpty ? 1 : 0)
                            Spacer()
                        }
                        .padding(.top, 1)
                    }
                }
                
                // Кнопки для выбора даты и времени
                HStack(spacing: 16) {
                    Button(action: {
                        withAnimation {
                            showDatePicker.toggle() // Показываем или скрываем DatePicker для даты
                        }
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                                .padding(.leading, 14)
                            
                            Text("Date")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(.trailing, 80)
                        }
                        .frame(width: 165, height: 42)
                        .background(Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation {
                            showTimePicker.toggle() // Показываем или скрываем DatePicker для времени
                        }
                    }) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                                .padding(.leading, 14)
                            
                            Text("Time")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(.trailing, 34)
                        }
                        .frame(width: 165, height: 42)
                        .background(Color(red: 5 / 255, green: 36 / 255, blue: 62 / 255))
                        .cornerRadius(10)
                    }
                }
                
                // Показываем DatePicker для выбора даты, если showDatePicker == true
                if showDatePicker {
                    VStack {
                        DatePicker("Select Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        Button(action: {
                            withAnimation {
                                showDatePicker = false // Скрываем DatePicker
                            }
                        }) {
                            Text("Close")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                        .padding(.top)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                }
                
                if showTimePicker {
                    VStack {
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        Button(action: {
                            withAnimation {
                                showTimePicker = false // Скрываем TimePicker
                            }
                        }) {
                            Text("Close")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                        .padding(.top)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Кнопки Cancel и Create
                HStack {
                    // Кнопка cancel
                    Button(action: {
                        withAnimation {
                            showPopup = false
                        }
                    }) {
                        Text("Cancel")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.black)
                            .frame(width: 165, height: 46)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 4)
                            )
                            .padding([.leading, .bottom], 27)
                        
                    }
                    
                    // Кнопка create
                    Button(action: {
                      
                        if titleTasks.isEmpty || taskDescription.isEmpty {
                            showAlert.toggle()
                        } else {
                        
                            let newTask = Task(
                                id: UUID(),
                                title: titleTasks,
                                description: taskDescription,
                                date: selectedDate,
                                time: selectedTime,
                                userEmail: signInViewModel.email
                            )
                            
             
                            taskViewModel.addTask(newTask)
                            
                        
                            showPopup = false
                        }
                    }) {
                        Text("Create")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 165, height: 46)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding([.trailing, .bottom], 27)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Missing Fields"), message: Text("Please fill out both the title and description."), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.55)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    var backgroundColor: UIColor
    var textColor: UIColor
    var cornerRadius: CGFloat
    var padding: CGFloat
    
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.textColor = textColor
        textView.backgroundColor = backgroundColor
        textView.layer.cornerRadius = cornerRadius
        textView.text = text
        textView.textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}

var email = "dasdasd"
#Preview {
    TasksPage(signInViewModel: .init(), showPopup: .constant(false), taskViewModel: .init(userEmail: email))
    
}
