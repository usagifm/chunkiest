//
//  TaskModelWatch.swift
//  ChunkistWatch WatchKit Extension
//
//  Created by Rafik Lutfi on 19/07/22.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var type: String
    var bgColor: Color
}

var TaskType = [
    Task(type: "Today", bgColor: .orange),
    Task(type: "Upcoming", bgColor: .cyan),
    Task(type: "Done", bgColor: .blue),
    Task(type: "Failed", bgColor: .purple),
]
