//
//  Home.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = .init()
    
    
    // Mark : Matched Geometry Namespace
    @Namespace var animation
    // hai ganteng
    
    
    // Mark: Fetching Task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    
    // MArk : Environment Values
    @Environment(\.self) var env
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack(alignment: .leading, spacing: 8){
                    Text("Welcome !")
                        .font(.callout)
                    Text("Here's Update Today.")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                
                CustomSegmentedBar()
                    .padding(.top, 5)
                
                // MARK : Task View
                TaskView().padding(.top,20)

           
                
            
            }.padding()
        }
        .overlay(alignment: .bottom){
            // MARK : Add Button
            Button {
                 taskModel.openEditTask.toggle()
            } label: {
                Label{
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }.foregroundColor(.white)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(.black, in: Capsule())
            }
            // Mark : Linear Gradient BG
            .padding(.top,10)
            .frame(maxWidth: .infinity)
     
            .background{
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
           
            
        }
        .fullScreenCover(isPresented: $taskModel.openEditTask){
            taskModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(taskModel)
        }
        .fullScreenCover(isPresented: $taskModel.openDetailTask){
            taskModel.resetTaskData()
        } content: {
            DetailTaskView()
                .environmentObject(taskModel)
        }
        
//        .fullScreenCover(isPresented: $taskModel.openEditTask){
//            AddNewTask()
//                .environmentObject(taskModel)
//        }
      
    }
    // Mark : TaskView
    @ViewBuilder
    func TaskView()->some View{
        LazyVStack(spacing: 20){
            
            // Mark : Custom Filtered REquest View
            // Liat video tentang dynamic request video dichannel yang sama
            // link di description
                
//            ForEach(tasks){task in
//                TaskRowView(task: task)
//
//            }
            
            DynamicFilteredView(currentTab: taskModel.currentTab){
                (task: Task) in
                TaskRowView(task: task)
                
                
            }
        }
    }
    // Mark : Task Row View
    
    @ViewBuilder
    func TaskRowView(task: Task)->some View{
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.4))
                    }
            
                Spacer()
                
                // Mark: Edit Button only for non completed task
//                if !task.isCompleted && taskModel.currentTab != "Failed"{
                    Button{
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black
                            )
                    }
                    
//                }
            }
            
            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical,10).onTapGesture {
                    print("Pressed Bro !")
                    taskModel.detailTask = task
                    taskModel.openDetailTask = true
                    taskModel.setupTask()
                }
            
            
            HStack(alignment: .bottom, spacing: 0){
                VStack(alignment: .leading, spacing: 10){
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }.font(.caption)
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                        
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted{
                    Button{
                        // MArk : Updating Core DAta
                        task.isCompleted.toggle()
                        
                        try? env.managedObjectContext.save()
                    } label: {
                        Circle()
                            .strokeBorder(.black, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }
                }
                Spacer()
    
            }
            
            Divider()
            if let subtasks = task.subtasks?.allObjects as? [Subtask]{
            Collapsible(
                label: { Text("Subtasks").font(.callout).bold() },
                            content: {
                                
                                ForEach(subtasks) { subtask in
                                    
                                    SubtaskRow(subtask: subtask)
                                   
                                }
                           
                            }
                        )
                        .frame(maxWidth: .infinity)
                
            }
            
//            HStack {
//                Group{
//
//                    Text("Subtasks ").font(.title3)
//                        .bold()
//                }
//
//                Spacer()
//
//
//                Button{
//
//                }label: {
//                    Image(systemName: "chevron.down").symbolVariant(.circle.fill)
//
//                }
//                .font(.title)
//                .foregroundStyle(.white.opacity(0.9))
//            }
        }.padding()
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(task.color ?? "Yellow"))
            }
  
        
    }
    
    // Mark : SubtaskRowView
    
    struct SubtaskRow: View {
        @ObservedObject var subtask: Subtask   // !! @ObserveObject is the key!!!

        var body: some View {
            HStack{
                            Group{
                             
                                Button{

                                                                subtask.isComplete.toggle()
               
                                                                              
                                    
                                        print("Subtask pressed!")
                                    
                                }
                                
                                
                            
                                label: {
                                    
                                    Image(systemName: subtask.isComplete ? "checkmark.circle.fill" : "circle.fill").foregroundColor(.white)
                                }
                                
                                    Text(subtask.name ?? "").font(.callout)
                                        .bold()
                                }
                
                                Spacer()
            }.padding(3)
        }
    }
    
    
    // MArk : Custom Segmented Bar !
    
    @ViewBuilder
    func CustomSegmentedBar()->some View{
        // Incase if we missed the task
        
        let tabs = ["Today", "Upcoming", "Task Done","Failed"]
        HStack(spacing: 10){
            ForEach(tabs,id: \.self){ tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical,6)
                    .frame(maxWidth: .infinity)
                    .background{
                        if taskModel.currentTab == tab{
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                            
                        }
                    }.contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{
                            taskModel.currentTab = tab
                        }
                    }
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
