//
//  TaskOverviewViewWatch.swift
//  ChunkistWatch WatchKit Extension
//
//  Created by Rafik Lutfi on 19/07/22.
//

import SwiftUI

struct TaskOverviewViewWatch: View {
    var body: some View {
        NavigationView {
            TaskWatch()
        }
    }
}


struct TaskWatch: View {
    
    struct Task: Identifiable {
        var id = UUID()
        var type: String
        var bgColor: Color
    }

    var TaskType = [
        Task(type: "Today", bgColor: .orange),
        Task(type: "Upcoming", bgColor: .cyan),
        Task(type: "Done", bgColor: .blue),
        Task(type: "Failed", bgColor: .purple),
    ]
    
    var body: some View {
        List(TaskType, id:\.id) { taskType in
            NavigationLink(destination: ListTaskByStatus(status: taskType.type)) {
                HStack {
                    Text(taskType.type)
                        .padding(.vertical, 15)
                    Spacer()
                    Text("1")
                }
            }
            .listItemTint(taskType.bgColor)
        }
        .navigationTitle("Your Task")
    }
}


struct ListTaskByStatus: View {
    var status: String
    // query buat dapetin listnya
    // 1. ngambilin data
    // 2. Fetch data
    
    var body: some View {
        Text(status)
    }
}

struct TodayWatch: View {
    var body: some View {
        Text("There is no task for today")
    }
}


struct TaskOverviewViewWatch_Previews: PreviewProvider {
    static var previews: some View {
        TaskOverviewViewWatch()
    }
}
