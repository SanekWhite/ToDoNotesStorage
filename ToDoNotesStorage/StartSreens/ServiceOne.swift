//
//  ServiceOne.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 20.12.2024.
//

import SwiftUI



struct ServiceOne: View {
    var body: some View {
        
      
           
            ZStack {
                Image(.gradient)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack() {
                    Image(.list)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 55)
                        .padding(.bottom, 65)
                    
                    Text("Plan your tasks to do, that\n way you’ll stay organized\n and you won’t skip any")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                
                }
            }
        
    }
}


#Preview {
    ServiceOne()
}
