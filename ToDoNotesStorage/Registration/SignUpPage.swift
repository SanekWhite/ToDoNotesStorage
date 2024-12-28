//
//  SignUpPage.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 22.12.2024.
//

import SwiftUI



struct SignUpPage:View {
    
    @StateObject var viewModel = SignUpViewModel()
    @State private var navigateToSignIn = false
    
    
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
                    
                    Text("Create an account and Join us now!")
                        .padding(.trailing, 50 )
                        .font(.system(size: 18))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                    
                    VStack {
                        HStack(spacing: 10) {
                            
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            TextField("Full Name", text: $viewModel.fullName)
                                .onChange(of: viewModel.fullName) { oldValue, newValue in
                                    let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }
                                    if filtered != newValue {
                                        viewModel.fullName = filtered
                                    }
                                }
                            
                                .padding(.vertical, 12)
                                .padding(.leading, 0)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(height: 50)
                            
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 22)
                        .padding(.bottom, 40)
                        
                        
                        HStack(spacing: 10) {
                            
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            TextField("E-mail", text: $viewModel.email)
                            
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.none)
                                .padding(.vertical, 12)
                                .padding(.leading, 0)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(height: 50)
                            
                            if !viewModel.isValidEmail && !viewModel.email.isEmpty {
                                Text("Invalid email format")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 10)
                            }
                            
                            
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 22)
                        .padding(.bottom, 40)
                        
                        
                        
                        
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
                        
                        if viewModel.password.count < 6 && !viewModel.password.isEmpty {
                            Text("Password must be at least 6 characters.")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.trailing, 10)
                        }
                    }
                    
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 22)
                    .padding(.bottom, 50)
                    
                    VStack {
                        Button(action: {
                            if viewModel.isValidForm() {
                                viewModel.defaults()
                                navigateToSignIn = true
                            }
                        }) {
                            Text("sign up")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, maxHeight: 42)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.horizontal, 25)
                                .padding(.bottom, 20)
                        }
                        
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        .navigationDestination(isPresented: $navigateToSignIn) {
                            SignInPageScreen()
                        }
                        
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Text("sign in")
                                .foregroundStyle(Color.cyan)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .onTapGesture {
                                    navigateToSignIn = true
                                }
                        }
                        
                    }
                    Spacer()
                }
                .padding(.top, 48)
            }
              .navigationBarBackButtonHidden(true)
        }
        
    }
}






#Preview {
    SignUpPage()
}
