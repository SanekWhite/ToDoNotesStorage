//
//  SignInPage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 21.12.2024.
//
import SwiftUI

struct SignInPageScreen: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.gradient)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    Image(.circle)
                        .frame(width: 85, height: 85)
                        .padding(.top, 30)
                    
                    HStack {
                        Text("Welcome back to")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Image(.toDo)
                            .resizable()
                            .frame(width: 70, height: 18)
                            .padding(.trailing, 104)
                    }
                    .padding(.top, 20)
                    
                    Text("Have an other productive day !")
                        .padding(.trailing, 90 )
                        .font(.system(size: 18))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                    
                    VStack {
                        
                        HStack(spacing: 10) {
                            
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            TextField("Email", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.none)
                                .padding(.vertical, 12)
                                .padding(.leading, 0)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(height: 50)
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 22)
                        .padding(.bottom, 56)
                    }
                    
                    HStack(spacing: 10) {
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        SecureField("Password", text: $viewModel.password)
                        
                        
                            .padding(.vertical, 12)
                            .padding(.leading, 0)
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(height: 50)
                        
                        
                    }
                    
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 22)
                    .padding(.bottom, 70)
                    
                    VStack {
                        
                        Button(action: {
                            viewModel.signIn() // Вызываем функцию signIn()
                            if viewModel.navigateToHome {
                                navigateToHome = true // Навигация при успешном входе
                            }
                        }) {
                            Text("sign in")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 18))
                                .frame(maxWidth: .infinity, maxHeight: 42)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.horizontal, 25)
                                .padding(.bottom, 20)
                        }
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Ok")))
                        }
                        
                        
                        HStack {
                            Text("Don’t have an account?")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            NavigationLink(destination: SignUpPage()) {
                                Text("sign up")
                                    .foregroundStyle(Color.cyan)
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                            }
                        }
                        
                    }
                    Spacer()
                }
                .padding(.top, 48)
            }
            .navigationDestination(isPresented: $navigateToHome) {
                // Передаем привязки, а не строки
                ScreenHomePage(email: $viewModel.email, fullName: $viewModel.fullName)
            }
        }
        
   
        .navigationBarBackButtonHidden(true)
    }
}





#Preview {
    SignInPageScreen()
}
