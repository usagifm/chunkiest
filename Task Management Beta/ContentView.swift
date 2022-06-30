//
//  ContentView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {


    var body: some View {
        NavigationView{
    
            TabView{
                
        
            Home().navigationTitle("Chunkiest")
                .navigationBarTitleDisplayMode(.inline)
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
            
        }
  
    }



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
