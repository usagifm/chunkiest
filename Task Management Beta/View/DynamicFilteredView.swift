//
//  DynamicFilteredView.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 22/06/22.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View,T>: View where T: NSManagedObject {
    // Mark: CoreData Request
    
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    // Mark:Building Custon ForEach which will give coredata object to build view
    init(currentTab: String,@ViewBuilder content: @escaping (T)->Content){
        
        
        // MArk : Predicate to filter current date tasks
        let calendar = Calendar.current
        var predicate: NSPredicate!
        if currentTab == "Today"{
            let today = calendar.startOfDay(for: Date())
            let tommorow = calendar.date(byAdding: .day,value:1, to: today)!
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [today,tommorow,0])
        }else if currentTab == "Upcoming"{
            
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day,value:1, to: Date())!)
            let tommorow = Date.distantFuture
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [today,tommorow,0])
            
            
        }else  if currentTab == "Task Done" {
            
            predicate = NSPredicate(format: "isCompleted == %i",
                                    argumentArray: [1])
        }else if currentTab == "Failed" {
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast
            
            // filter Key
            let filterKey = "deadline"
            
            // this will fetch task between today and tommowrow which is 24 hours
            // 0-flase, 1-true
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i",
                                    argumentArray: [past,today,0])
            
            
            
        }
        
        // initalizing request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        self.content = content
        
    }
    
    
    var body: some View {
       
        Group{
            if request.isEmpty{
                Text("No Task Found!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            }else{
                ForEach(request,id: \.objectID){object in
                    self.content(object)
                    
                }
                
            }
        }
        
    }
}

