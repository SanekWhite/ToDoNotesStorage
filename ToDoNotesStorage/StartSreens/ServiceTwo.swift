//
//  ServiceTwo.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 20.12.2024.
//

import SwiftUI

struct ServiceTwo: View {
    var body: some View {
        ZStack {
        
            Image(.gradient)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                Image(.listTwo)
              
                    .scaledToFit()
            
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                Text("Make a full schedule for\n the whole week and stay\n organized and productive\n all days")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                 .font(.system(size: 20))
                 .fontWeight(.bold)
                    
                
                Spacer()
                
               
            }
        }
    }
}
