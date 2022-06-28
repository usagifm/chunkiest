//
//  TaskViewModel.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    

    @Published var subtaskArray: [Subtask] = []
    
    @Published var currentTab: String = "Today"
    
    // Mark : New Task Properties
    @Published var openEditTask: Bool = false
    @Published var openDetailTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var taskDescription: String = ""
    @Published var showDatePicker: Bool = false
    
    // Mark : Editing Existing Task
    @Published var editTask: Task?
    @Published var detailTask: Task?
    
    // Mark : For adding subtask
    @Published var subTaskName: String = ""
    
    
    

    // MARK : Adding task to CoreData
    
    func addTask(context: NSManagedObjectContext)-> Bool{
        
        // Mark : Updating Existing Task Data in CoreData
        var task: Task!
        if let editTask = editTask {
            task = editTask
        }else{
            task = Task(context: context)
        }
        
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.taskDescription = taskDescription
        task.isCompleted = false
        
        if let _ = try? context.save(){
            
            print("Berhasil !")
            return true
            

        }
        
        return false
        
    }
//
//    func reFetchData(){
//
////        @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var realtimeTasks: FetchedResults<Task>
////
////        return realtimeTasks
//
//        let request = NSFetchRequest<TaskEntity>(entityName: "Task")
//
//        let sort = NSSortDescriptor(key: "deadline", ascending: true)
//
////       let fallbackSort = NSSortDescriptor(key: <#T##String?#>, ascending: <#T##Bool#>)
//
//        request.sortDescriptors = [sort]
//
//        do {
//            try tasksArray =
//        }
//
//    }
    
//    func loadExercises() {
//        
//        // Request objects that match our model
//        let request = NSFetchRequest<ExerciseEntity>(entityName: K.CoreData.parentEntityName)
//        
//        // SORT RULES:
//        // Priority or basic sort mean sort by a special attribute in CoreData Item.
//        // That allow us to save changes in order by user.
//        let sort = NSSortDescriptor(key: K.CoreData.basicSortingKey, ascending: true)
//        let fallbackSort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
//        
//        // Applying sorting
//        request.sortDescriptors = [sort, fallbackSort]
//        
//        do {
//            // Try to load the result into the monitored array
//            try exercisesArray = persistenceController.container.viewContext.fetch(request)
//        } catch {
//            // If it doesn't work
//            print("Error getting data. \(error.localizedDescription)")
//        }
//    }
//
    
    
    func completeSubtask(context: NSManagedObjectContext, subtask:Subtask)-> Bool{
        
        // Mark : Updating Existing Task Data in CoreData
        var subtaskUpdate: Subtask!
//        if let editTask = editTask {
//            task = editTask
//        }else{
//            task = Task(context: context)
//        }
//
        subtaskUpdate = subtask
        subtaskUpdate.isComplete.toggle()
        
        if let _ = try? context.save(){
            
            print("Berhasil ! update complete pake VM")
            return true
            

        }
        
        return false
        
    }
    
    func addSubtask(context: NSManagedObjectContext, task: Task)-> Bool{
        
        
        var newSubtask: Subtask!
        

        let subtasks = detailTask!.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]
        
        newSubtask = Subtask(context: context)
        newSubtask.name = subTaskName
        newSubtask.isComplete = false
        newSubtask.order = (subtasks?.last?.order ?? 0) + 1
        print("Nilai last order : \(subtasks?.last?.order)")
        newSubtask.task = task
        

        
        if let _ = try? context.save(){
            
            print("Berhasil Menambah Data Subtask!")
            return true
            
        }
        
        return false
        
        
    }
    
    // Mark Resetting data
    
    func resetTaskData(){
        taskType = "Basic"
        taskTitle = ""
        taskColor = "Yellow"
        taskDeadline = Date()
        taskDescription = ""
        editTask = nil
        detailTask = nil
        subTaskName = ""
    }
    
    // Mark : If Edit task is available then setting existing data
    func setupTask(){
        if let editTask = editTask {
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Yellow"
            taskTitle = editTask.title ?? ""
            taskDeadline = editTask.deadline ?? Date()
            taskDescription = editTask.taskDescription ?? ""
        }
        
        if let detailTask = detailTask {
            taskType = detailTask.type ?? "Basic"
            taskColor = detailTask.color ?? "Yellow"
            taskTitle = detailTask.title ?? ""
            taskDeadline = detailTask.deadline ?? Date()
            taskDescription = detailTask.taskDescription ?? ""
            subtaskArray = (detailTask.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask])!
        }
    }
}

