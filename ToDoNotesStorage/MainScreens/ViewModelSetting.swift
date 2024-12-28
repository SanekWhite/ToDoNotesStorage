//
//  ViewModelSetting.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 25.12.2024.
//


import Foundation

class ViewModelSetting: ObservableObject {
    @Published var viewModel: [SettingModel] = [.init(sections: [.init(name: "Profile", icon: .init("person.circle"))]),
                                                .init(sections: [.init(name: "Conversations", icon: .init("message.fill"))]),
                                                .init(sections: [.init(name: "Projects", icon: .init("lightbulb.min.badge.exclamationmark.fill"))]),
                                                .init(sections: [.init(name: "Terms and Policies", icon: .init("text.page.badge.magnifyingglass"))])
    
    
    
    
    
    ]
    
    
}
