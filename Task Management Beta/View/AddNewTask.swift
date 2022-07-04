//
//  AddNewTask.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI

struct AddNewTask: View {
    @EnvironmentObject var taskModel: TaskViewModel
    
    @State var editMode: EditMode = .active
    @State var isEditing = true
    
    // MARK : All Environment Values in one variable !
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        GeometryReader { g in
            ScrollView {

        VStack{
            Text("Add New Task")
                .font(.title3.bold())
//                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button {
                        taskModel.subtaskArrayToAdd = []
                        env.dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.title3)
//                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .trailing){
                    Button {
                        // Mark : IF success closing the View
                        if  taskModel.addTask(context: env.managedObjectContext) {
                            taskModel.subtaskArrayToAdd = []
                            taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
                            env.dismiss()
                        }
                    } label: {
                        Text("Save")
//                        Image(systemName: "trash")
//                            .font(.title3)
//                            .foregroundColor(.red)
                   
                    }
                            .disabled(taskModel.taskTitle == "")
                        .opacity(taskModel.taskTitle == "" ? 0.6 : 1)

                }
            
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // Mark : Sample Card Color
                let colors: [String] = ["Yellow","Green", "Blue","Purple","Red","Orange"]
                
                HStack(spacing: 15){
                    ForEach(colors,id: \.self){color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background{
                                if taskModel.taskColor == color{
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3)
                                    
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                taskModel.taskColor = color
                            }
                        
                        
                    }
                }.padding(.top,10)
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding(.top,30)
            
            Divider()
                .padding(.vertical,10)
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Deadline")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(taskModel.taskDeadline.formatted(date: .abbreviated, time:.omitted) + ", " + taskModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
//                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.top,8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing){
                Button{
                    taskModel.showDatePicker.toggle()
                }label: {
                    Image(systemName: "calendar")
//                        .foregroundColor(.black)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
            }
            
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Description")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskModel.taskDescription)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
            }
            
            
            Divider()
            let taskTypes: [String] = ["Basic","Urgent","Important"]
            VStack(alignment: .leading, spacing: 12){
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    ForEach(taskTypes,id: \.self){type in
                        Text(type)
                            .font(.callout)
                            .padding(.vertical,8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskModel.taskType == type ? .white : Color("BlueAccent"))
                            .background{
                                if taskModel.taskType == type{
                                    Capsule()
                                        .fill( Color("BlueAccent"))
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                    
                                }else {
                                    Capsule()
                                        .strokeBorder(Color("BlueAccent"))
                                }
                                
                            }.contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{
                                    taskModel.taskType = type
                                }
                            }
                        
                        
                    }
                }.padding(.top,8)
                
                Divider()
                
                
                HStack(alignment: .bottom, spacing: 0){
                    VStack(alignment: .leading, spacing: 10){
                        
                        HStack(alignment: .bottom, spacing: 0){
                            VStack(alignment: .leading, spacing: 10){
                            
                                
                                Text("Subtask").font(.headline).bold()
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                    }
                }.padding(10)
//                    .padding(.bottom,20)
                
                
//
                // Save Button
                
//                Button{
//
//                    // Mark : IF success closing the View
//                    if  taskModel.addTask(context: env.managedObjectContext) {
//
//                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                        env.dismiss()
//                    }
//
//                }label: {
//                    Text("Save Task")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical,12)
//                        .foregroundColor(.white)
//                        .background{
//
//                            Capsule()
//                                .fill(.black)
//                        }
//
//                }.frame(maxHeight: .infinity, alignment: .bottom)
//                    .padding(.bottom,10)
//                    .disabled(taskModel.taskTitle == "")
//                    .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
                
                
                
                List{
                    
                    ForEach(taskModel.subtaskArrayToAdd) { subtask in
                        SubtaskRowInDetailTaskView(subtask: subtask)
                    }.onMove(perform: moveSubtask)
                        .onDelete(perform: deleteSubtask)
                    Text("Add Subtask...")
                        .foregroundColor(.red)
                    
                        .onTapGesture {
                            
                          taskModel.addSubtaskForAdd(context: env.managedObjectContext)
                            
                        }

                }
                .frame(width: g.size.width - 30, height: 200, alignment: .center)
                .frame(maxWidth: .infinity)
//                    .onAppear(perform: {
//
//                        taskModel.loadSubtasks(task: taskModel.detailTask!)
//
//                    })
                    .listStyle(.plain)
                    .environment(\.editMode, $editMode)
                
                
                
            }

            
            
            
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay{
            ZStack{
                if taskModel.showDatePicker{
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture{
                            taskModel.showDatePicker = false
                        }
                    
                    
                    // Mark Disabling past dates
                    DatePicker.init("", selection: $taskModel.taskDeadline, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(Color(UIColor.systemFill), in:RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                    
                }
                
            }
            .animation(.easeInOut, value: taskModel.showDatePicker)
        }
        
        
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
//                Text("Order : \(subtask.order)")
                
//                    .onChange(of: subtask.name, perform: { _ in
//                        taskModel.editSubtaskName(context: env.managedObjectContext, subtask: subtask)
//                        //                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                        print("Berhasil edit subtask")
//                    })
                
            }
        }
    }
    
    
    
    private func moveSubtask(at sets:IndexSet,destination:Int){
        let subtaskToMove = sets.first!
        
        if subtaskToMove < destination {
            var startIndex = subtaskToMove + 1
            let endIndex = destination - 1
            var startOrder = taskModel.subtaskArrayToAdd[subtaskToMove].order
            while startIndex <= endIndex{
                taskModel.subtaskArrayToAdd[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            taskModel.subtaskArrayToAdd[subtaskToMove].order = startOrder
        }
        else if destination < subtaskToMove {
            var startIndex = destination
            let endIndex = subtaskToMove - 1
            var startOrder = taskModel.subtaskArrayToAdd[destination].order + 1
            let newOrder = taskModel.subtaskArrayToAdd[destination].order
            while startIndex <= endIndex {
                taskModel.subtaskArrayToAdd[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            taskModel.subtaskArrayToAdd[subtaskToMove].order = newOrder
        }
        do {
            taskModel.subtaskArrayToAdd = taskModel.subtaskArrayToAdd.sorted(by: { $0.order < $1.order })
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    private func deleteSubtask(at offset:IndexSet){
        withAnimation{
            taskModel.subtaskArrayToAdd.remove(atOffsets: offset)
            do {
                print("\(taskModel.subtaskArrayToAdd[0].name) WKOWKOKWOKWKWOKWOKKWO")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask().environmentObject(TaskViewModel())
    }
}

//extension EditMode {
//    
//    mutating func toggle() {
//        self = self == .active ? .inactive : .active
//    }
//}
