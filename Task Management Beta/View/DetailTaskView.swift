//
//  DetailTaskView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 27/06/22.
//

import SwiftUI

struct DetailTaskView: View {
    
    //    @State var editMode: EditMode = .inactive //<- Declare the @State var for editMode
    @State var editMode: EditMode = .active
    @State var isEditing = true
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var taskModel: TaskViewModel
    // MARK : All Environment Values in one variable !
    @Environment(\.self) var env
    
    @Namespace var animation
    
    @State var subtaskName: String = ""
    
    @State var subtasks: [Subtask] = []
    
    //    subtasks = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]
    //
    
    
    
    var body: some View {
        //        NavigationView {
        
        VStack{
            Text("Detail Task")
                .font(.title3.bold())
//                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button {
                        taskModel.resetTaskDataForDetail()
                        //                        
                        //                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
                        env.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                        Text("Home")
//                            .foregroundColor(.black)
                    }
                }.overlay(alignment: .trailing){
                    Button {
                        if let detailTask = taskModel.detailTask{
                            taskModel.openDetailTask = false
                            env.managedObjectContext.delete(detailTask)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }.opacity(taskModel.detailTask == nil ? 0 : 1)
                }
            
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text(taskModel.detailTask?.type ?? "")
                        .foregroundColor(.white)
                        .font(.callout)
                        .padding(.vertical,5)
                        .padding(.horizontal)
                        .background{
                            Capsule()
                                .fill(.black.opacity(0.8))
                        }
                    
                    Spacer()
                    
                    Button{
                        taskModel.editTask = taskModel.detailTask
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black
                            )
                    }
                    
                    
                    
                    
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
                
                Text(taskModel.detailTask?.title ?? "")
                    .font(.title2.bold())
                    .foregroundColor(.black)
                //                    .padding(.vertical,10).onTapGesture {
                //                        print("Pressed Bro !")
                //                        taskModel.detailTask = task
                //                        taskModel.openDetailTask = true
                //                        taskModel.setupTask()
                //                    }
                //
                Text(taskModel.detailTask?.taskDescription ?? "")
                    .font(.callout)
                    .foregroundColor(.black)
                
                HStack(alignment: .bottom, spacing: 0){
                    VStack(alignment: .leading, spacing: 10){
                        Label {
                            Text((taskModel.detailTask?.deadline ?? Date()).formatted(date: .long, time: .omitted)).foregroundColor(.black)
                        } icon: {
                            Image(systemName: "calendar").foregroundColor(.black)
                        }.font(.caption)
                        
                        Label {
                            Text((taskModel.detailTask?.deadline ?? Date()).formatted(date: .omitted, time: .shortened)).foregroundColor(.black)
                        } icon: {
                            Image(systemName: "clock").foregroundColor(.black)
                            
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
                    
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("WhiteCardDetail"),   Color(taskModel.detailTask?.color ?? "Yellow")]), startPoint: .leading, endPoint: .trailing)
                            
                        )
                    
                    //                        .background(
                    //                               LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .leading, endPoint: .trailing)
                    //                           )
                }
            
            HStack(alignment: .bottom, spacing: 0){
                VStack(alignment: .leading, spacing: 10){
                    
                    HStack(alignment: .bottom, spacing: 0){
                        VStack(alignment: .leading, spacing: 10){
                            
                            let subtaskCompleted = taskModel.subtaskArray.filter() {
                                let isComplete = $0.isComplete == true
                                
                                return isComplete
                            }
                            
                            Text("Subtask \("(\(String(subtaskCompleted.count))/\(String(taskModel.subtaskArray.count)))" ?? "0/0")").font(.headline).bold()
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                }
            }.padding(10)
                .padding(.bottom,20)
            
            //            if let subtasksNew = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]{
            //                subtasks.append(contentsOf: subtasksNew)
            
            //            if let subtasks = taskModel.detailTask?.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]{
            
            
            
            List{
                
                ForEach(taskModel.subtaskArray) { subtask in
                    SubtaskRowInDetailTaskView(subtask: subtask)
                }.onMove(perform: moveSubtask)
                    .onDelete(perform: deleteSubtask)
                //                            Button{
                //
                //                                if  taskModel.addSubtask(context: env.managedObjectContext, task: taskModel.detailTask!){
                //
                //                                    taskModel.detailTask = taskModel.detailTask
                //                                    taskModel.loadSubtasks(task: taskModel.detailTask!)
                //
                //                                }
                //
                //
                //
                //                            }label: {
                Text("Add Subtask...")
                    .foregroundColor(.red)
                
                    .onTapGesture {
                        
                        if  taskModel.addSubtask(context: env.managedObjectContext, task: taskModel.detailTask!){
                            
                            taskModel.detailTask = taskModel.detailTask
                            taskModel.loadSubtasks(task: taskModel.detailTask!)
                            
                        }
                        
                        
                    }
                //                            }
            }.frame(maxWidth: .infinity)
                .onAppear(perform: {
                    
                    taskModel.loadSubtasks(task: taskModel.detailTask!)
                    
                })
                .listStyle(.plain)
                .environment(\.editMode, $editMode)
            
            //                            Button("Edit", action:{
            //                            isEditing.toggle()
            //                            editMode = isEditing ? .active : .inactive
            //                            })
            
            
            //                }
            
            
            
            
            //        }
            //                    .toolbar {
            //                        EditButton()
            //                    }
            
            
        }
        .onDisappear(){
            taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .fullScreenCover(isPresented: $taskModel.openEditTask){
            taskModel.resetTaskDataForDetail()
        } content: {
            EditDetailTaskView()
                .environmentObject(taskModel)
        }
        
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
            taskModel.loadSubtasks(task: taskModel.detailTask!)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    private func deleteSubtask(at offset:IndexSet){
        withAnimation{
            offset.map{ taskModel.subtaskArray[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
                taskModel.loadSubtasks(task: taskModel.detailTask!)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    struct SubtaskRowInDetailTaskView: View {
        @ObservedObject var subtask: Subtask   // !! @ObserveObject is the key!!!
        
        @EnvironmentObject var taskModel: TaskViewModel
        // MARK : All Environment Values in one variable !
        @Environment(\.self) var env
        
        var body: some View {
            HStack{
                //        Text(subtask.name ?? "")
                TextField("Subtask Name", text: $subtask.name.toUnwrapped(defaultValue: ""))
                    .onChange(of: subtask.name, perform: { _ in
                        taskModel.editSubtaskName(context: env.managedObjectContext, subtask: subtask)
                        //                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
                        print("Berhasil edit subtask")
                    })
                
            }
        }
    }
    
    
}




struct DetailTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTaskView().environmentObject(TaskViewModel())
    }
}
extension EditMode {
    
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
