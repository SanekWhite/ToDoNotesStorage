//
//  CalendarView.swift
//  ToDoNotesStorage
//
//  Created by Александр Белый on 28.12.2024.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date
    var tasks: [Task]

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.selectionColor = .systemBlue
        calendar.appearance.todayColor = .systemRed
        calendar.allowsMultipleSelection = false
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedDate: $selectedDate, tasks: tasks)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        @Binding var selectedDate: Date
        var tasks: [Task]

        init(selectedDate: Binding<Date>, tasks: [Task]) {
            _selectedDate = selectedDate
            self.tasks = tasks
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date
        }

        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            // Подсветка дней с задачами
            return tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }.count
        }
    }
}
