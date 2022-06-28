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
            
            Home().navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
            
        }
  
    }



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
