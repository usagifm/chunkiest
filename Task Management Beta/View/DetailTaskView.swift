//
//  DetailTaskView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 27/06/22.
//

import SwiftUI

struct DetailTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var taskModel: TaskViewModel
    // MARK : All Environment Values in one variable !
    @Environment(\.self) var env
    
    @State var subtaskName: String = ""
    
    @State var subtasks: [Subtask] = []
    
//    subtasks = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]
//
    
    var body: some View {
        NavigationView {
        VStack{
            Text("Detail Task")
                .font(.title3.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button {
                        env.dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text(taskModel.taskType ?? "")
                        .font(.callout)
                        .padding(.vertical,5)
                        .padding(.horizontal)
                        .background{
                            Capsule()
                                .fill(.white.opacity(0.4))
                        }
                
                    Spacer()
                    
                    // Mark: Edit Button only for non completed task
//                    if !task.isCompleted && taskModel.currentTab != "Failed"{
//                        Button{
//                            taskModel.editTask = task
//                            taskModel.openEditTask = true
//                            taskModel.setupTask()
//                        }label: {
//                            Image(systemName: "square.and.pencil")
//                                .foregroundColor(.black
//                                )
//                        }
//
//                    }
                }
                
                Text(taskModel.taskTitle ?? "")
                    .font(.title2.bold())
                    .foregroundColor(.black)
//                    .padding(.vertical,10).onTapGesture {
//                        print("Pressed Bro !")
//                        taskModel.detailTask = task
//                        taskModel.openDetailTask = true
//                        taskModel.setupTask()
//                    }
//
                Text(taskModel.taskDescription ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                HStack(alignment: .bottom, spacing: 0){
                    VStack(alignment: .leading, spacing: 10){
                        Label {
                            Text((taskModel.taskDeadline ?? Date()).formatted(date: .long, time: .omitted))
                        } icon: {
                            Image(systemName: "calendar")
                        }.font(.caption)
                        
                        Label {
                            Text((taskModel.taskDeadline ?? Date()).formatted(date: .omitted, time: .shortened))
                        } icon: {
                            Image(systemName: "clock")
                            
                        }
                        .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
//                    if !taskModel.isCompleted{
//                        Button{
//                            // MArk : Updating Core DAta
//                            task.isCompleted.toggle()
//
//                            try? env.managedObjectContext.save()
//                        } label: {
//                            Circle()
//                                .strokeBorder(.black, lineWidth: 1.5)
//                                .frame(width: 25, height: 25)
//                                .contentShape(Circle())
//                        }
//                    }
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(taskModel.taskColor ?? "Yellow"))
                }
            
            
            
            VStack(alignment: .leading, spacing: 12){
                Text("Subtask Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskModel.subTaskName)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                
                Button{
                    
                    if  taskModel.addSubtask(context: env.managedObjectContext, task: taskModel.detailTask!){
                        
                        taskModel.detailTask = taskModel.detailTask
                        
                    }
                    
                 
                    
                }label: {
                    Text("Add Subtask")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(10))
                }
            }
            
           
            
//            if let subtasksNew = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]{
//                subtasks.append(contentsOf: subtasksNew)
            
            if let subtasks = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]{

                
                    VStack{
                        List{

                            ForEach(subtasks) { subtask in
                                SubtaskRowInDetailTaskView(subtask: subtask)
                            }.onMove(perform: moveSubtask)
                            .onDelete(perform: deleteSubtask)
                            
                        }
                      
                        
                    }
                
                    
                }

            
        }
                    .toolbar {
                        EditButton()
                    }
            
            
        }      .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            
      
    }
    
    
    private func moveSubtask(at sets:IndexSet,destination:Int){
        let subtaskToMove = sets.first!
        
        if subtaskToMove < destination {
            var startIndex = subtaskToMove + 1
            let endIndex = destination - 1
            var startOrder = taskModel.subtaskArray[subtaskToMove].order
            while startIndex <= endIndex{
                taskModel.subtaskArray[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            taskModel.subtaskArray[subtaskToMove].order = startOrder
        }
        else if destination < subtaskToMove {
            var startIndex = destination
            let endIndex = subtaskToMove - 1
            var startOrder = taskModel.subtaskArray[destination].order + 1
            let newOrder = taskModel.subtaskArray[destination].order
            while startIndex <= endIndex {
                taskModel.subtaskArray[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            taskModel.subtaskArray[subtaskToMove].order = newOrder
        }
        do {
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    private func deleteSubtask(at offset:IndexSet){
        withAnimation{
            offset.map{ taskModel.subtaskArray[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
}


    
struct SubtaskRowInDetailTaskView: View {
    @ObservedObject var subtask: Subtask   // !! @ObserveObject is the key!!!

    var body: some View {
        HStack{
        Text(subtask.name ?? "")
        Text("Order No : \(subtask.order)").font(.caption)
        }
    }
}

struct DetailTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTaskView().environmentObject(TaskViewModel())
    }
}
