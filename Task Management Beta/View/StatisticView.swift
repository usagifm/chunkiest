//
//  StatisticView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 01/07/22.
//

import SwiftUI

struct StatisticView: View {
    @StateObject var taskModel: TaskViewModel = .init()

    var body: some View {
        VStack{
        VStack(spacing: 18) {
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.title.bold())
                    }
                    Spacer(minLength: 10)
                }
   
            }
            .padding()
            Divider()
            TaskProgress(title: "Task Done", color: Color("BlueAccent"), image: "", progress: CGFloat(taskModel.countTotalPercentageTaskDone))
            VStack(alignment: .center){
                HStack(alignment: .firstTextBaseline,spacing: 0){
                    Spacer()
                    UserProgress(title: "Today", color: Color("Blue"), image: "circle", progress: CGFloat(taskModel.countTodayTask)).padding()
                        //.border(.black)
                    Spacer()
                    UserProgress(title: "Done", color: Color("Green"), image: "checkmark", progress: CGFloat(taskModel.countDoneTask))
                        .padding()
                        //.border(.black)
                    Spacer()
                }.frame(maxWidth: .infinity)
                HStack(spacing: 0){
                    Spacer()
                    UserProgress(title: "Upcoming", color: Color("Orange"), image: "calendar", progress: CGFloat(taskModel.countUpcomingTask)).padding()
                        .padding(.leading,19)
                        //.border(.black)
                    Spacer()
                    UserProgress(title: "Failed", color: Color("Red"), image: "xmark", progress: CGFloat(taskModel.countFailedTask)).padding()
                        .padding(.trailing,15)
                        //.border(.black)
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .padding(.top, 50)
            .onAppear(perform: {
                taskModel.loadStatiscticDatas()
            })
        }
        
    }
    @ViewBuilder
    func TaskProgress(title: String, color: Color, image: String, progress: CGFloat) -> some View {
        ZStack(alignment: .center){
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(color)
                .background(
                    ZStack{
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                        Circle()
                            .trim(from: 0, to: progress / 100)
                            .stroke(color, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                    }
                        .frame(width: 200, height: 200)
                )
            VStack (alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                Text("\(Int(progress)) % ")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Text(title)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
            }
        }
        .padding(.top, 200)
    }
    func UserProgress(title: String, color: Color, image: String, progress: CGFloat) -> some View{
        HStack{
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(color)
                .padding(10)
                .background(
                    ZStack{
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        Circle()
                            .trim(from: 0, to: 100 / 100)
                            .stroke(color, lineWidth: 2)
                    }
                )
            VStack(alignment: .leading, spacing: 8){
                Text("\(Int(progress))")
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
