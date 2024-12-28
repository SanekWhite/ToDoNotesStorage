//
//  ServiceFour.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 20.12.2024.
//

import SwiftUI

struct ServiceFour: View {
    var body: some View {
       
            
            ZStack {
                
                Image(.gradient)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack() {
                    Image(.listFour)
                    
                        .scaledToFit()
                    
                        .padding(.top, 75)
                        .padding(.bottom, 80)
                    Text("You informations are\n secure with us")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    HStack {
                        
                        
                        ZStack {
                            
                          // Image(.emptyNext)
                          //
                          //     .frame(width: 70, height: 70)
                          //     .foregroundColor(.white)
                          //     .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 0)
                        
                         //       Image(.nextButton)
                         //
                         //           .frame(width: 40, height: 40)
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    } .padding(.trailing, 35)
                        .padding(.bottom, 25)
                }
            }
        }
    }



#Preview {
    ServiceFour()
}
