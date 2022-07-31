//
//  SwiftUIView.swift
//  Task Management WatchOS WatchKit Extension
//
//  Created by Jauza Krito on 19/07/22.
//

import SwiftUI

struct SwiftUIView: View {
    @State var taskProgress: Double = 0.4
    
    @StateObject var taskModel: TaskViewModelWatch = .init()
    
    
    @Environment(\.self) var env
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    CircularTaskProgressView(taskProgress: taskModel.countTotalPercentageTaskDone)
                    VStack {
                    Text("\(taskModel.countTotalPercentageTaskDone * 100, specifier: "%.0f") %")
                            .font(.system(size: 13.75))
                    Text("Task Done")
                            .font(.system(size: 13.75))
                    }
                    .foregroundColor(Color.blue)
                }
                .frame(width: 116, height: 116)
            }
            .onAppear(perform: {
                // Call when view appears
                taskModel.loadStatiscticDatas()
          
            })
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CircularTaskProgressView: View {
    let taskProgress: Float
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    Color.blue.opacity(0.3),
                    lineWidth: 12.69
                )
            Circle()
                .trim(from: 0, to: CGFloat(taskProgress))
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 12.69,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
