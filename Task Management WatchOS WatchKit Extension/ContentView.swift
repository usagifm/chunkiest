//
//  ContentView.swift
//  Task Management WatchOS WatchKit Extension
//
//  Created by Jauza Krito on 18/07/22.
//

import SwiftUI
import ClockKit

struct ContentView: View {
    @State var progress: Float
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        CircularComplicationView(progress: progress)
    }
}

struct CircularComplicationView: View {
    @State var progress: Float = 0
    var body: some View {
        ZStack {
            ProgressView(value: progress)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
            Text("\(Int(progress * 100))%")
        }
    }
    
}

//struct RectangularComplicationView: View {
//    @State var progress: Float
//    var body: some View {
//        HStack {
//            CircularComplicationView(progress: progress)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CLKComplicationTemplateGraphicCircularView(CircularComplicationView(progress: 0.80))
            .previewContext()
//        CLKComplicationTemplateGraphicRectangularFullView(RectangularComplicationView(progress: 0.76))
//            .previewContext()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
