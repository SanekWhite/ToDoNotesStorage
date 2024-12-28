//
//  ServiceFour.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 20.12.2024.
//

import SwiftUI

struct ServiceThree: View {
    var body: some View {
        ZStack {
        
            Image(.gradient)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                Image(.listThree)
              
                    .scaledToFit()
            
                    .padding(.top, 92)
                    .padding(.bottom, 97)
                Text("Create a team task, invite\n people and manage your\n work together")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                 .font(.system(size: 20))
                 .fontWeight(.bold)
                    
                
                Spacer()
                
            
            }
        }
    }
}
