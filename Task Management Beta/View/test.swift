////
////  Home.swift
////  Task Management Beta
////
////  Created by Muhammad Nur Faqqih on 21/06/22.
////
//
//import SwiftUI
//
//struct Home: View {
//    @StateObject var taskModel: TaskViewModel = .init()
//
//    // Mark : Matched Geometry Namespace
//    @Namespace var animation
//
//    // Mark: Fetching Task
//    //    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
//    //
//
//    // MArk : Environment Values
//    @Environment(\.self) var env
//
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            VStack{
//                VStack(alignment: .leading){
//                    Text("Welcome !")
//                        .font(.callout)
//                    Text("Here's Update Today.")
//                        .font(.title2.bold())
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.vertical)
//
//
//                CustomSegmentedBar()
//                    .padding(.top, 5)
//
//                // MARK : Task View
//                TaskView().padding(.top,20)
//
//
//
//
//            }.padding()
//        }
//        .onAppear(perform: {
//
//            taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//
//            print(" FUCKING ON APPEAR TOT")
//        })
//        .overlay(alignment: .bottom){
//            // MARK : Add Button
//            Button {
//                taskModel.openAddTask.toggle()
//            } label: {
//                Label{
//                    Text("Add Task")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                } icon: {
//                    Image(systemName: "plus.app.fill")
//                }.foregroundColor(.white)
//                    .padding(.vertical,12)
//                    .padding(.horizontal)
//                    .background(.black, in: Capsule())
//            }
//            // Mark : Linear Gradient BG
//            .padding(.top,10)
//            .frame(maxWidth: .infinity)
//
//            .background{
//                LinearGradient(colors: [
//                    .white.opacity(0.05),
//                    .white.opacity(0.4),
//                    .white.opacity(0.7),
//                    .white
//                ], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//            }
//
//
//        }
//        .fullScreenCover(isPresented: $taskModel.openAddTask){
//            taskModel.resetTaskData()
//        } content: {
//            AddNewTask()
//                .environmentObject(taskModel)
//        }
//        .fullScreenCover(isPresented: $taskModel.openDetailTask){
//            taskModel.resetTaskData()
//        } content: {
//            DetailTaskView()
//                .environmentObject(taskModel)
//        }
//
//        //        .fullScreenCover(isPresented: $taskModel.openEditTask){
//        //            AddNewTask()
//        //                .environmentObject(taskModel)
//        //        }
//
//    }
//    // Mark : TaskView
//    @ViewBuilder
//    func TaskView()->some View{
//        VStack(spacing: 20){
//
//            // Mark : Custom Filtered REquest View
//            // Liat video tentang dynamic request video dichannel yang sama
//            // link di description
//
//            //            ForEach(tasks){task in
//            //                TaskRowView(task: task)
//            //
//            //            }
//
////            DynamicFilteredView(currentTab: taskModel.currentTabEnum.rawValue){
////                            (task: Task) in
////                                TaskRowView(task: task)
////                        }
//                                ForEach(taskModel.taskArray,id: \.self){ task in
//                                    TaskRowView(task: task)
//                                }
//
//
//            //            }
//        }
//    }
//    // Mark : Task Row View
//
//    @ViewBuilder
//    func TaskRowView(task: Task)->some View{
//        VStack(alignment: .leading, spacing: 10){
//            //            HStack{
//            //                Text(task.type ?? "")
//            //                    .font(.callout)
//            //                    .padding(.vertical,5)
//            //                    .padding(.horizontal)
//            //                    .background{
//            //                        Capsule()
//            //                            .fill(.white.opacity(0.4))
//            //                    }
//
//            //                Spacer()
//
//            // Mark: Edit Button only for non completed task
//            //                if !task.isCompleted && taskModel.currentTab != "Failed"{
//            //                    Button{
//            //                        taskModel.editTask = task
//            //                        taskModel.openEditTask = true
//            //                        taskModel.setupTask()
//            //                    }label: {
//            //                        Image(systemName: "square.and.pencil")
//            //                            .foregroundColor(.black
//            //                            )
//            //                    }
//
//            //                }
//            //            }
//
//            HStack(alignment: .bottom, spacing: 0){
//                VStack(alignment: .leading, spacing: 5){
//                    Text(task.title ?? "")
//                        .font(.title2.bold())
//                        .foregroundColor(.black)
//                        .padding(.top,5)
//
//
//                    Text(task.taskDescription ?? "")
//                        .font(.callout)
//                        .foregroundColor(.black)
//                        .onTapGesture {
//                            print("Pressed Bro !")
//                            //                    taskModel.detailTask = task
//                            //                    taskModel.openDetailTask = true
//                            //                    taskModel.setupTask()
//                        }
//
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                //                NavigationLink(destination: DetailTaskView().environmentObject(taskModel)) {
//                //                    Text("Trade View Link")
//                //                }.simultaneousGesture(TapGesture().onEnded{
//                //
//                //                    taskModel.detailTask = task
//                //                    taskModel.openDetailTask = true
//                //                    taskModel.setupTask()
//                //
//                //                })
//                Button{
//                    // MArk : Updating Core DAta
//
//
//                    print("Pressed Bro !")
//
//                    taskModel.detailTask = task
//                    taskModel.openDetailTask = true
//                    taskModel.setupTask()
//
//                    //                task.isCompleted.toggle()
//                    //
//                    //                try? env.managedObjectContext.save()
//                } label: {
//
//
//                    Image(systemName: "chevron.right")
//                        .resizable()
//                        .foregroundColor(.black)
//                        .frame(width: 10, height: 15)
//                    //                            .contentShape(Circle())
//                        .padding(.bottom, 30)
//
//
//
//
//                }
//
//
//
//            }
//
//
//
//            HStack(alignment: .bottom, spacing: 0){
//                VStack(alignment: .leading, spacing: 5){
//                    Label {
//                        Text( "\(((task.deadline ?? Date()).formatted(date: .complete, time: .omitted)) ), \((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened)) ")
//                    } icon: {
//                        Image(systemName: "calendar")
//                    }.font(.caption)
//
//                    //                    Label {
//                    //                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
//                    //                    } icon: {
//                    //                        Image(systemName: "clock")
//                    //
//                    //                    }
//                    //                    .font(.caption)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                //                if !task.isCompleted{
//                //                    Button{
//                //                        // MArk : Updating Core DAta
//                //                        task.isCompleted.toggle()
//                //
//                //                        try? env.managedObjectContext.save()
//                //                    } label: {
//                //                        Circle()
//                //                            .strokeBorder(.black, lineWidth: 1.5)
//                //                            .frame(width: 25, height: 25)
//                //                            .contentShape(Circle())
//                //                    }
//                //                }
//                Spacer()
//
//            }
//
//            if let subtasks = task.subtasks?.sortedArray(using: [NSSortDescriptor(key: "order", ascending: true)]) as? [Subtask]{
//
//                //                @State var Tawda: String
//
//                let subtaskCompleted = subtasks.filter() {
//                    let isComplete = $0.isComplete == true
//
//                    return isComplete
//                }
//                //
//                //                let subtaskNotCompleted = subtasks.filter() {
//                //                    let isComplete = $0.isComplete == false
//                //
//                //                    return isComplete
//                //                }
//
//                HStack{
//
//
//                    Text("\(String(subtaskCompleted.count))/\(String(subtasks.count))" ?? "0/0")
//                        .foregroundColor(Color.white)
//                        .font(.subheadline)
//                        .bold()
//
//                        .padding(.vertical,5)
//                        .padding(.horizontal)
//
//                        .background{
//                            Capsule()
//                                .fill(Color(task.color ?? "Yellow"))
//                        }
//                        .onTapGesture {
//                            //                    print("Pressed Bro !")
//                            //                    taskModel.detailTask = task
//                            //                    taskModel.openDetailTask = true
//                            //                    taskModel.setupTask()
//
//                        }
//
//                    Text(task.type ?? "")
//                        .font(.subheadline)
//                        .padding(.vertical,5)
//                        .padding(.horizontal)
//                        .background{
//                            Capsule()
//                                .fill(Color(task.color ?? "Yellow").opacity(0.4))
//                        }
//
//
//                }
//
//                HStack{
//
//
//                    if subtaskCompleted.count == 0 && subtasks.count == 0 {
//                                        ProgressView(value: 0, total:100).tint(Color(task.color ?? "Yellow")).padding()
//                    }else {
//                        HStack{
//
//                            ProgressView(value: Float(subtaskCompleted.count), total: Float(subtasks.count)).tint(Color(task.color ?? "Yellow")).padding()
//                            Text("\(String(subtaskCompleted.count))/\(String(subtasks.count))")
//
//                        }
//                    }
//
//                    //                if subtasks.count != 0 {
//                    //
//                    //                ProgressView(value: Float(subtaskCompleted.count), total: Float(subtasks.count)).tint(Color(task.color ?? "Yellow")).padding()
//                    //
//                    //                    Text("\(String(subtaskCompleted.count))/\(String(subtasks.count))")
//                    //
//                    //                } else if subtasks.count == 0 {
//                    //
//                    //                ProgressView(value: 0, total:100).tint(Color(task.color ?? "Yellow")).padding()
//                    //
//                    //                }
//                    //
//                    //                    if subtasks.count == 0 {
//                    //
//                    //
//                    //                    }
//
//
//                    //            if !task.isCompleted{
//                    Button{
//                        // MArk : Updating Core DAta
//                        task.isCompleted.toggle()
//                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//
//                        try? env.managedObjectContext.save()
//                    } label: {
//
//                        if task.isCompleted == true {
//
//                            Image(systemName: "checkmark.circle.fill")
//                                .resizable()
//                                .foregroundColor(.blue)
//                                .frame(width: 25, height: 25)
//                                .contentShape(Circle())
//                                .padding(.bottom, 5)
//
//                        }
//                        if task.isCompleted == false {
//
//                            Image(systemName: "circle")
//                                .resizable()
//                                .foregroundColor(.gray)
//                                .frame(width: 25, height: 25)
//                                .contentShape(Circle())
//                                .padding(.bottom, 5)
//                        }
//
//
//                    }
//                    //            }
//                }
//
//                //            Divider()
//
//                if subtasks.count != 0 {
//                    Collapsible(
//                        label: { Text(" ").font(.callout).bold() },
//                        content: {
//
//                            ForEach(subtasks) { subtask in
//                                            SubtaskRow(subtask: subtask)
//
//                                Divider()
//                            }
//
//                        }
//                    )
//                    .frame(maxWidth: .infinity)
//
//                }
//            }
//            //            HStack {
//            //                Group{
//            //
//            //                    Text("Subtasks ").font(.title3)
//            //                        .bold()
//            //                }
//            //
//            //                Spacer()
//            //
//            //
//            //                Button{
//            //
//            //                }label: {
//            //                    Image(systemName: "chevron.down").symbolVariant(.circle.fill)
//            //
//            //                }
//            //                .font(.title)
//            //                .foregroundStyle(.white.opacity(0.9))
//            //            }
//        }
//        //        .onAppear(perform: {
//        //
//        //            taskModel.loadTasks(currentTab: taskModel.currentTab)
//        //
//        //            })
//        .padding()
//        .frame(maxWidth: .infinity)
//        .background{
//            RoundedRectangle(cornerRadius: 12, style: .continuous)
//            //                    .fill(Color(task.color ?? "Yellow"))
//                .fill(Color.white)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: 1)
//                ).opacity(0.3)
//        }
//
//
//    }
//
//    // Mark : SubtaskRowView
//
//    struct SubtaskRow: View {
//        @StateObject var taskModel: TaskViewModel = .init()
//
//        @Environment(\.self) var env
//
//       @StateObject  var subtask: Subtask   // !! @ObserveObject is the key!!!
//
//        var body: some View {
//            HStack{
//                Group{
//
//                    Button{
//
//                        subtask.isComplete.toggle()
//                        print("Subtask pressed!")
//                        try? env.managedObjectContext.save()
//                        taskModel.loadTasks(currentTab: taskModel.currentTabEnum)
//                    }
//
//                label: {
//
//                    if subtask.isComplete == true {
//
//                        Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
//                    }
//                    if subtask.isComplete == false {
//
//                        Image(systemName: "circle").foregroundColor(.gray)
//                    }
//
//                    //                                    Image(systemName: subtask.isComplete ? "checkmark.circle.fill" : "circle.fill").foregroundColor(.blue)
//                }
//
//                    Text(subtask.name ?? "").font(.footnote)
//                    //                                        .bold()
//                }
//
//                Spacer()
//            }.padding(3)
//        }
//    }
//
//
//    // MArk : Custom Segmented Bar !
//
//    @ViewBuilder
//    func CustomSegmentedBar()->some View{
//        // Incase if we missed the task
//
//        let tabs: [segmentedEnum] = [.today, .upcoming, .taskDone, .failed]
//        HStack(spacing: 10){
//            ForEach(tabs,id: \.self){ tab in
//                Text(tab.rawValue)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .scaleEffect(0.9)
//                    .foregroundColor(taskModel.currentTabEnum == tab ? .white : Color("BlueAccent"))
//                    .padding(.vertical,6)
//                    .frame(maxWidth: .infinity)
//                    .background{
//                        if taskModel.currentTabEnum == tab{
//                            Capsule()
//                                .fill(Color("BlueAccent"))
//                                .matchedGeometryEffect(id: "TAB", in: animation)
//
//                        }
//                        if taskModel.currentTabEnum != tab{
//
//                            Capsule()
//                                .stroke(Color("BlueAccent"),lineWidth: 2)
//
//
//                        }
//
//
//                    }.contentShape(Capsule())
//                    .onTapGesture {
//                        withAnimation{
//                            taskModel.currentTabEnum = tab
//                            taskModel.loadTasks(currentTab: tab)
//                        }
//                    }
//            }
//
//        }
//    }
//
//
//
//}
//
//
//extension View {
//    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
//        if isHidden {
//            self.hidden()
//        } else {
//            self
//        }
//    }
//}
//
//
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
