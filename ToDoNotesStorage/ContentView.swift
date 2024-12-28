//
//  ContentView.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 20.12.2024.
//
import SwiftUI

struct StartScreen: View {
    @State private var currentIndex: Int = 0
    @State private var navigateToSignIn: Bool = false 


    let screens: [AnyView] = [
        AnyView(ServiceOne()),
        AnyView(ServiceTwo()),
        AnyView(ServiceThree()),
        AnyView(ServiceFour())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.gradient)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                // Основной контент
                TabView(selection: $currentIndex) {
                    ForEach(0..<screens.count, id: \.self) { index in
                        screens[index]
                            .onTapGesture {
                                currentIndex = index
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .padding(.bottom, 90)
                .ignoresSafeArea()
                
                // Кнопки для управления экранами
                HStack {
                    if currentIndex == screens.count - 1 {
                 
                        Button(action: {
                            navigateToSignIn = true
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                                    .shadow(color: Color.white.opacity(0.5), radius: 10, x: 0, y: 0)
                                
                                Image(.nextButton)
                                    .frame(width: 40, height: 40)
                            }
                        }
                        .padding(.trailing, 35)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        
                    } else if currentIndex < screens.count - 1 {
                        
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .shadow(color: Color.white.opacity(0.5), radius: 10, x: 0, y: 0)
                            .onTapGesture {
                                withAnimation {
                                    currentIndex += 1
                                }
                            }
                            .padding(.trailing, 35)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                }
                .padding(.bottom, 56)
            }
            .navigationDestination(isPresented: $navigateToSignIn) {
                SignInPageScreen()
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        StartScreen()
    }
}

#Preview {
    ContentView()
}
