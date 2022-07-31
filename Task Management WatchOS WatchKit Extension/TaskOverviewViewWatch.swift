//
//  TaskOverviewViewWatch.swift
//  ChunkistWatch WatchKit Extension
//
//  Created by Rafik Lutfi on 19/07/22.
//

import SwiftUI
import WatchKit

struct TaskOverviewViewWatch: View {
    var body: some View {
        NavigationView {
            TaskWatch()
        }
    }
}


struct TaskWatch: View {
    
    
    @StateObject var taskModel: TaskViewModelWatch = .init()
    
    @Environment(\.self) var env
    
    struct TaskOverview: Identifiable {
        var id = UUID()
        var type: String
        var bgColor: Color
        var totalTask: Int
    }

    @State var TaskType: [TaskOverview] = []
    
    var body: some View {
        VStack{
        
//            Button {
//                taskModel.addTaskDummy(context: env.managedObjectContext)
//            } label: {
//                Label{
//
//                } icon: {
//                    Image(systemName: "plus")
//                }.foregroundColor(.white)
//                    .padding(.vertical)
//                    .padding(.horizontal)
//                    .background(
//                          RoundedRectangle(cornerRadius: 25)
//                              .fill(Color("BlueAccent"))
//                              .shadow(color: .blue, radius: 2, x: 0, y: 3)
//                  )
//            }
            
        List(TaskType, id:\.id) { taskType in
            NavigationLink(destination: ListTaskByStatus(status: taskType.type).environment(\.managedObjectContext, env.managedObjectContext)) {
                HStack {
                    Text(taskType.type)
                        .bold()
                        .padding(.vertical, 15)
                    Spacer()
                    Text("\(taskType.totalTask)")  .bold()
                }
            }
            .listItemTint(
                   taskType.bgColor
             )
            
            
        }
        .onAppear(perform: {
            
             TaskType = [
                TaskOverview(type: "Today", bgColor: .orange, totalTask: taskModel.loadStatisticDataToday()),
                TaskOverview(type: "Upcoming", bgColor: .cyan, totalTask: taskModel.loadStatisticDataUpcoming()),
                TaskOverview(type: "Done", bgColor: .blue, totalTask: taskModel.loadStatisticDataDone()),
                TaskOverview(type: "Failed", bgColor: .purple, totalTask: taskModel.loadStatisticDataFailed()),
            ]
            
            // Call when view appears
            taskModel.loadStatiscticDatas()
      
        })
        .navigationTitle("Your Task")
        .navigationBarTitleDisplayMode(.inline)
    }
    }
}


struct ListTaskByStatus: View {
    
    @StateObject var taskModel: TaskViewModelWatch = .init()
    
    @Environment(\.managedObjectContext) var context
    
    var status: String
    // query buat dapetin listnya
    // 1. ngambilin data
    // 2. Fetch data
    
    var body: some View {
        
        VStack{
            List(taskModel.taskArray, id:\.id) { task in
                
                
//                HStack(alignment: .top, spacing: 0){
                    
                
//                VStack(ali){
                    
                    
               
            GeometryReader { geometry in
//                HStack(alignment: .center){
                    
                HStack{
                    
                    VStack(alignment: .leading){
                        Text(task.title ?? "")
//                        .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,5)
                    
                    
                        Text( "\(((task.deadline ?? Date()).formatted(date: .numeric, time: .omitted)) ) | \((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.caption2)
                           
                    
                }
                  
                .frame(width: geometry.size.width * 0.7)
                
                HStack{
                    
                    Button{
                        // MArk : Updating Core DAta
//                            task.isCompleted.toggle()
//                            taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                            complexSuccess()
//                            try? env.managedObjectContext.save()
                        
    //                        task.isCompleted.toggle()
    //                        
    //                        try? env.managedObjectContext.save()
    //
//                        playSoundOnce(sound: "pop", type: "mp3")
//
                        if task.isCompleted == false {
                        WKInterfaceDevice.current().play(.success)
                        }
                        
                        
                        if task.isCompleted == true {
                            WKInterfaceDevice.current().play(.failure)
                        }
                        taskModel.completeTask(context: context, task: task)
                        
                        taskModel.loadTasks(currentTab: segmentedEnum(rawValue: status) ?? segmentedEnum.today)
                        
                    }
                        label: {
                                
                                if task.isCompleted == true {
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .frame(width: 25, height: 25)
                                        .contentShape(Circle())
                                        .padding(.top, 5)
                                    
                                }
                                if task.isCompleted == false {
                                    
                                    Image(systemName: "circle")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 25, height: 25)
                                        .contentShape(Circle())
                                        .padding(.top, 5)
                                }
                                
                                
                            }
                    
                }        .frame(width: geometry.size.width * 0.3)
                    
                
                        
                    
                }
                
                .frame(maxWidth: .infinity)
                }
                
                    
//                Button{
//                    // MArk : Updating Core DAta
//
//
//                    print("Pressed Bro !")
////                    taskModel.detailTask = task
////                    taskModel.openDetailTask = true
////                    taskModel.setupTask()
//
//                    //                task.isCompleted.toggle()
//                    //
//                    //                try? env.managedObjectContext.save()
//                } label: {
//
//
//                    Image(systemName: "arrow.right.circle.fill")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                    //                            .contentShape(Circle())
//                        .padding(.bottom, 30)
////                        .padding(.trailing, 3)
//
//
//
//
//                }
//
                
                
//            }
            
                
    
                
                
            
            
        }
            .navigationTitle(status)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                
                taskModel.loadTasks(currentTab: segmentedEnum(rawValue: status) ?? segmentedEnum.today)
            })
       
        
        }
        
        
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
