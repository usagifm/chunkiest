//
//  ContentView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @AppStorage("isStart") private var isStart: Bool = false
    
    var body: some View {
        
        if isStart {
            
            TabView{
                
        
            Home()
                .tabItem{
                     Image(systemName: "house")
                    Text("Home")
                }
                
              StatisticView()
                    .tabItem{
                         Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Statistic")
                    }
            }
            
        } else {
            OnBoardingView()
        }
//        NavigationView{
    

            
//        }
  
    }



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
