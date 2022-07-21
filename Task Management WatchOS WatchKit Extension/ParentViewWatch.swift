//
//  ParentViewWatch.swift
//  Task Management WatchOS WatchKit Extension
//
//  Created by Rafik Lutfi on 21/07/22.
//

import SwiftUI

struct ParentViewWatch: View {
    var body: some View {
        TabView {
            SwiftUIView()
            TaskOverviewViewWatch()
        }
    }
}

struct ParentViewWatch_Previews: PreviewProvider {
    static var previews: some View {
        ParentViewWatch()
    }
}

//struct ParentView: View {
//    @State var currentView = 1
//    
//    @State var isPlayingSomething : Bool = false
//    @State var playingSong : Song?
//    
//    var body: some View {
//        TabView(selection: $currentView) {
//            ContentView(isPlayingSomething: $isPlayingSomething, playingSong: $playingSong).tag(1)
//            ListSongView(isPlayingSomething: $isPlayingSomething, playingSong: $playingSong,tagView: $currentView).tag(2)
//        }
//    }
//}
