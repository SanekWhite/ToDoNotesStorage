//
//  SettingPage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 23.12.2024.
//

import SwiftUI


struct SettingPage: View {
    @ObservedObject var viewModelSetting: ViewModelSetting
    @Environment(\.dismiss) var dismiss
    @State private var pressedItemID: UUID?
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        ZStack {
            Image(.gradient)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            List {
                ForEach(viewModelSetting.viewModel) { item in
                    ForEach(item.sections) { setting in
                        Button(action: {
                            // Эмулируем нажатие
                            withAnimation {
                                pressedItemID = setting.id
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                    pressedItemID = nil
                                }
                            }
                        }) {
                            HStack {
                                
                                
                                Image(systemName: setting.icon)
                                    .foregroundColor(pressedItemID == setting.id ? .red : .white)
                                    .font(.system(size: 25))
                                    .foregroundStyle(Color.white)
                                
                                Text("\(setting.name)")
                                    .foregroundColor(pressedItemID == setting.id ? .red : .white)
                                    .padding()
                                Spacer()
                                Image(.arrowNext)
                                    .padding(.trailing, 34)
                                
                                
                            }
                        }
                        .buttonStyle(.plain) // Убираем стандартное оформление кнопки
                    }
                }
                
                .listRowSeparatorTint(Color.gray)
                .listRowBackground(Color.clear)
            }
            
            .listStyle(PlainListStyle())
            
            VStack {
                Button(action: {
                    showLogoutAlert = true
                }) {
                    ZStack {
                        HStack {
                            Image(.signIn)
                            
                            Text("Logout")
                                .foregroundStyle(Color.red)
                                .font(.system(size: 16))
                                .kerning(2)
                        }
                        .frame(width: 226, height: 42)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
                .padding(.top, 100)
                
            }
            
            .padding(.bottom, 20)
            
        }
        .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {
                
            }
            Button("Yes", role: .destructive) {
                dismiss() // Завершить текущий экран
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingPage(viewModelSetting: ViewModelSetting())
}
