//
//  ComplicationsView.swift
//  SepotipaiW WatchKit Extension
//
//  Created by Darma Wiryanata on 18/07/22.
//

import SwiftUI
import ClockKit

struct ComplicationsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: Circular
struct CircularComplicationViewLagi: View {
    
    @State var progress: Float = 0
    
    var body: some View {
        ZStack {
            ProgressView(value: progress)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
            
            Text("\(Int(progress * 100))%")
        }
    }
    
}


struct ComplicationsView_Previews: PreviewProvider {
    static var previews: some View {
        CLKComplicationTemplateGraphicCircularView(CircularComplicationView(progress: 0.1))
            .previewContext()
        
 
    }
}
