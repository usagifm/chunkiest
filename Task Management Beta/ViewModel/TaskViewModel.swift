//
//  TaskViewModel.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI
import CoreData

enum segmentedEnum: String{
    case today = "Today"
    case upcoming = "Upcoming"
    case taskDone = "Task Done"
    case failed = "Failed"
}



//
//struct Model {
//    var taskArrayBaru: [Task] = []
//}
//
//class TaskController: ObservableObject {
//    @Published var model = Model()
//    @StateObject var persistenceController = PersistenceController.shared
//    
//    
////    var viewContext = PersistenceController.shared.container.viewContext
//
//    var taskItem: [Task] {
//        get {
//
//            do {
//                try taskArray = persistenceController.container.viewContext.fetch(request)
//                print("Task sukses di ambil !")
//                
//            }catch{
//                // If it doesn't work
//                print("Error getting data. \(error.localizedDescription)")
//            }
//            
//        }
//    }
//
////    func addItemToTicket(withName name: String, price: Double) {
////        let item = Item(context: viewContext)
////        item.name = name
////        item.price = price
////        item.id = UUID()
////        model.ticket.append(item)
////    }
//    
//}
//class statisticDataStruct{
//    var today: Int
//    var upcoming: Int
//    var done: Int
//    var failed: Int
//    var percentage: Float
//
//    init(today: Int, upcoming: Int, done: Int, failed: Int, percentage: Float) {
//        self.today = today
//        self.upcoming = upcoming
//        self.done = done
//        self.failed = failed
//        self.percentage = percentage
//    }
//}

class TaskViewModel: ObservableObject {
    
    
    private let persistenceController = PersistenceController.shared
    
    @Published var countTodayTask:Int = 0
    @Published var countUpcomingTask:Int = 0
    @Published var countDoneTask:Int = 0
    @Published var countFailedTask:Int = 0
    
    @Published var countTotalPercentageTaskDone:Float = 0
  
    
    @Published var statisticData: [Task] = []
    
    @Published var subtaskArray: [Subtask] = []
    
    @Published var subtaskArrayToAdd: [Subtask] = []
    
    
    @Published var taskArray: [Task] = []
    //    @StateObject var taskAnjing = TaskController()
    
    @Published var currentTab: String = "Today"
    
    @Published var currentTabEnum: segmentedEnum = .today
    
    // Mark : New Task Properties
    @Published var openEditTask: Bool = false
    @Published var openAddTask: Bool = false
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
    
    // Array yang isinya subtask dari sebuah 
    
    
    
    // MARK : Adding task to CoreData
    
    
    func sendNotificationDaysBefore( taskDeadline: Date, howManyDaysBefore: Int, notificationTitle: String, notificationSubtitle: String){
        
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.subtitle = notificationSubtitle
        content.sound = UNNotificationSound.default
        
        let modifiedDate = Calendar.current.date(byAdding: .day, value: howManyDaysBefore, to: taskDeadline)!
//        print(modifiedDate)
//        print("Coookk !")

        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour,.minute], from: modifiedDate)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
//    func sendNotificationOneWeekBefore(taskTitle: String, taskDeadline: Date){
//
//        let content = UNMutableNotificationContent()
//        content.title = "Heads up !"
//        content.subtitle = "You still have one day for \(taskTitle)"
//        content.sound = UNNotificationSound.default
//
//        let modifiedDate = Calendar.current.date(byAdding: .day, value: -7, to: taskDeadline)!
////        print(modifiedDate)
////        print("Coookk !")
//
//
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: modifiedDate)
////        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        // choose a random identifier
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        // add our notification request
//        UNUserNotificationCenter.current().add(request)
//    }
//
    func addTask(context: NSManagedObjectContext)-> Bool{
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        // Mark : Updating Existing Task Data in CoreData
        var task: Task!
        if let editTask = editTask {
            task = editTask
        }else{
            task = Task(context: context)
        }
        
        // send notif 7 days before deadline
        
        sendNotificationDaysBefore(taskDeadline: taskDeadline, howManyDaysBefore: -7, notificationTitle: "Slowly but surely, bit by bit !", notificationSubtitle: "You have 1 Week left for \(taskTitle), let’s do it bit by bit!")
          
        // send notif 1 day before deadline
        sendNotificationDaysBefore(taskDeadline: taskDeadline, howManyDaysBefore: -1, notificationTitle: "Heads up !", notificationSubtitle: "You still have one day for \(taskTitle), You can do it bit by bit !")
          
        
        
        task.id = UUID()
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.taskDescription = taskDescription
        task.isCompleted = false
        
        
        
        if subtaskArrayToAdd.count != 0 {
            for subtask in subtaskArrayToAdd{
                subtask.task = task
            }
            
        }
        
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
    //
    //    if let currentExerciseIndex = exercisesArray.firstIndex(where: { $0.id == exercise.id }) {
    //
    //        // Request objects that match our model
    //        let request = NSFetchRequest<IteranceEntity>(entityName: K.CoreData.childeEntityName)
    //
    //        let currentExercise = exercisesArray[currentExerciseIndex]
    //        request.predicate = NSPredicate(format: "%K == %@", "parentExercise.id" , currentExercise.id! as CVarArg)
    //
    //        // SORT RULES:
    //        // Priority or basic sort mean sort by a special attribute in CoreData Item.
    //        // That allow us to save changes in order by user.
    //        let sort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
    //
    //        // Applying sorting
    //        request.sortDescriptors = [sort]
    //
    //        do {
    //            // Try to load the result into the monitored array
    //            try iterancesArray = persistenceController.container.viewContext.fetch(request)
    //
    //            var sumOfFetchedIterances: Int16 = 0
    //            for iterance in iterancesArray {
    //                sumOfFetchedIterances += iterance.number
    //            }
    //            currentExercise.sumOfIterances = sumOfFetchedIterances
    //
    //            // Computing today iterances
    //            var sumOfToDayIterances: Int16 = 0
    //            let calendar = Calendar.current
    //            let todayIterances = iterancesArray.filter({calendar.isDateInToday($0.timestamp!)})
    //            for iterance in todayIterances {
    //                sumOfToDayIterances += iterance.number
    //            }
    //            currentExercise.toDayIterances = sumOfToDayIterances
    //
    //            saveData()
    //
    //        } catch {
    //  _esn't work
    //  _Error getting data. \(error.localizedDescription)")
    //  __
    //    }
    
    func loadStatiscticDatas(){
     
         countTodayTask = loadStatisticDataToday()
         countUpcomingTask = loadStatisticDataUpcoming()
         countDoneTask = loadStatisticDataDone()
         countFailedTask = loadStatisticDataFailed()
        
        countTotalPercentageTaskDone = Float(countTodayTask + countUpcomingTask + countDoneTask + countFailedTask)
        print("Total percentage : \(countTotalPercentageTaskDone)")
        if countTotalPercentageTaskDone > 0 {
            countTotalPercentageTaskDone = ( Float(countDoneTask) / countTotalPercentageTaskDone) * 100
            print("Total percentage after precentaged : \(countTotalPercentageTaskDone)")
        }else {
            countTotalPercentageTaskDone = 0
        }
    }
    
    func loadStatisticDataFailed() -> Int {
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sort = NSSortDescriptor(key: "type", ascending: true)
        request.sortDescriptors = [sort]
        
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        let today = calendar.startOfDay(for: Date())
        let past = Date.distantPast
        
        // filter Key
        let filterKey = "deadline"
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        
        predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                argumentArray: [past,today,0])
        request.predicate = predicate
        
        var jumlah: Int = 0
        do {
        try statisticData = persistenceController.container.viewContext.fetch(request)
            jumlah = statisticData.count
            print(statisticData.count)
            print("Berhasil.")
        }catch{
            print("Belum berhasil")
        }
        return jumlah
    }
    
    func loadStatisticDataDone() -> Int {
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sort = NSSortDescriptor(key: "type", ascending: true)
        request.sortDescriptors = [sort]
        
        var predicate: NSPredicate!
        predicate = NSPredicate(format: "isCompleted == %i",
                                argumentArray: [1])
        request.predicate = predicate
        
        var jumlah: Int = 0
        do {
        try statisticData = persistenceController.container.viewContext.fetch(request)
            jumlah = statisticData.count
            print(statisticData.count)
            print("Berhasil.")
        }catch{
            print("Belum berhasil")
        }
        return jumlah
    }
    
    func loadStatisticDataUpcoming()-> Int {
        
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sort = NSSortDescriptor(key: "type", ascending: true)
        request.sortDescriptors = [sort]
        
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        let today = calendar.startOfDay(for: calendar.date(byAdding: .day,value:1, to: Date())!)
        let tommorow = Date.distantFuture
        
        // filter Key
        let filterKey = "deadline"
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        
        predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                argumentArray: [today,tommorow,0])
        
        request.predicate = predicate

        var jumlah: Int = 0
        do {
        try statisticData = persistenceController.container.viewContext.fetch(request)
            jumlah = statisticData.count
            print(statisticData.count)
            print("Berhasil.")
            
         
        }catch{
            print("Belum berhasil")
        }
        
        return jumlah
        
    }
    func loadStatisticDataToday()-> Int {
        
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sort = NSSortDescriptor(key: "type", ascending: true)
        request.sortDescriptors = [sort]
        
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        let today = calendar.startOfDay(for: Date())
        let tommorow = calendar.date(byAdding: .day,value:1, to: today)!
        
        // filter Key
        let filterKey = "deadline"
        
        // this will fetch task between today and tommowrow which is 24 hours
        // 0-flase, 1-true
        
        predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                argumentArray: [today,tommorow,0])
        request.predicate = predicate

        var jumlah: Int = 0
        do {
        try statisticData = persistenceController.container.viewContext.fetch(request)
            jumlah = statisticData.count
            print(statisticData.count)
            print("Berhasil.")
            
         
        }catch{
            print("Belum berhasil")
        }
        
        return jumlah
        
        
    }
    
    func loadTasks(currentTab: segmentedEnum) {
        
        
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        //        print(task)
        
        //        request.predicate = NSPredicate(format: "%K == %@", "task.id", task.id! as CVarArg )
        
        let sort = NSSortDescriptor(key: "type", ascending: false)
        
        request.sortDescriptors = [sort]
        
        
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        switch currentTab {
            
        case .today:
            let today = calendar.startOfDay(for: Date())
            let tommorow = calendar.date(byAdding: .day,value:1, to: today)!
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [today,tommorow,0])
        case .upcoming:
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day,value:1, to: Date())!)
            let tommorow = Date.distantFuture
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [today,tommorow,0])
            
        case .taskDone:
            predicate = NSPredicate(format: "isCompleted == %i",
                                    argumentArray: [1])
        case .failed:
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [past,today,0])
        }
        
        
        //        if currentTab == "Today"{
        //            let today = calendar.startOfDay(for: Date())
        //            let tommorow = calendar.date(byAdding: .day,value:1, to: today)!
        //
        //            // filter Key
        //            let filterKey = "deadline"
        //
        //            // this will fetch task between today and tommowrow which is 24 hours
        //            // 0-flase, 1-true
        //
        //            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
        //                                    argumentArray: [today,tommorow,0])
        //
        //        }else if currentTab == "Upcoming"{
        //
        //            let today = calendar.startOfDay(for: calendar.date(byAdding: .day,value:1, to: Date())!)
        //            let tommorow = Date.distantFuture
        //
        //            // filter Key
        //            let filterKey = "deadline"
        //
        //            // this will fetch task between today and tommowrow which is 24 hours
        //            // 0-flase, 1-true
        //
        //            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
        //                                    argumentArray: [today,tommorow,0])
        //
        //
        //        }else  if currentTab == "Task Done" {
        //
        //            predicate = NSPredicate(format: "isCompleted == %i",
        //                                    argumentArray: [1])
        //        }else if currentTab == "Failed" {
        //            let today = calendar.startOfDay(for: Date())
        //            let past = Date.distantPast
        //
        //            // filter Key
        //            let filterKey = "deadline"
        //
        //            // this will fetch task between today and tommowrow which is 24 hours
        //            // 0-flase, 1-true
        //
        //            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
        //                                    argumentArray: [past,today,0])
        //
        //
        //
        //        }
        //
        request.predicate = predicate
        
        do {
            try taskArray = persistenceController.container.viewContext.fetch(request)
            print("Task sukses di ambil !")
            
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    
    func loadSubtasks(task: Task) {
        
        
        
        
        let request = NSFetchRequest<Subtask>(entityName: "Subtask")
        
        print(task)
        
        request.predicate = NSPredicate(format: "%K == %@", "task.id", task.id! as CVarArg )
        
        let sort = NSSortDescriptor(key: "order", ascending: true)
        
        request.sortDescriptors = [sort]
        
        //        let requestTask = NSFetchRequest<Task>(entityName: "Task")
        //        
        ////        print(task)
        //        
        //        requestTask.predicate = NSPredicate(format: "%K == %@", "id", task.id! as CVarArg )
        
        //        let sortTask = NSSortDescriptor(key: "order", ascending: true)
        
        //        request.sortDescriptors = [sort]
        
        do {
            try subtaskArray = persistenceController.container.viewContext.fetch(request)
            //            try taskkArray = persistenceController.container.viewContext.fetch(requestTask)
            
            //            detailTask = taskkArray[0]
            
        }catch{
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }
    
    
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
        newSubtask.id = UUID()
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
    
    
    func addSubtaskForAdd(context: NSManagedObjectContext){
        
        
        var newSubtask: Subtask!
        
        
            subtaskArrayToAdd = subtaskArrayToAdd.sorted(by: { $0.order < $1.order })
        
            newSubtask = Subtask(context: context)
            newSubtask.id = UUID()
            newSubtask.name = subTaskName
            newSubtask.isComplete = false
            newSubtask.order = (subtaskArrayToAdd.last?.order ?? 0) + 1
        
            subtaskArrayToAdd.append(newSubtask)
//        print("Nilai last order : \(subtasks?.last?.order)")
//        newSubtask.task = task
        
        
        
//        if let _ = try? context.save(){
//
//            print("Berhasil Menambah Data Subtask!")
//            return true
//
//        }
//
//        return false
        
        
    }
    
    
    func editSubtaskName(context: NSManagedObjectContext, subtask: Subtask)-> Bool{
        
        
        //        var newSubtask: Subtask!
        //
        //
        //        let subtasks = detailTask!.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]
        
        //        newSubtask = Subtask(context: context)
        //        newSubtask.name = subTaskName
        //        newSubtask.isComplete = false
        //        newSubtask.order = (subtasks?.last?.order ?? 0) + 1
        //        print("Nilai last order : \(subtasks?.last?.order)")
        //        newSubtask.task = task
        
        
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
        //        taskArray = []
    }
    
    func resetTaskDataForDetail(){
        taskType = "Basic"
        taskTitle = ""
        taskColor = "Yellow"
        taskDeadline = Date()
        taskDescription = ""
        editTask = nil
        //        detailTask = nil
        subTaskName = ""
        taskArray = []
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

