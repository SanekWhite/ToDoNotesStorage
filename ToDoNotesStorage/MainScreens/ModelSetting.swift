//
//  ModelSetting.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 25.12.2024.
//

import SwiftUI
import Foundation



struct SettingModel: Identifiable {
    let id = UUID()
    
    var sections: [NameSection]
    
    struct NameSection: Identifiable {
        let id = UUID()
        var name: String
        var icon: String
    }
  
  
    
}
