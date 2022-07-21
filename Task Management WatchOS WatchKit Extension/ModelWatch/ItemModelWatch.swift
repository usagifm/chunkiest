//
//  ItemModelWatch.swift
//  ChunkistWatch WatchKit Extension
//
//  Created by Rafik Lutfi on 20/07/22.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isComplete: Bool
}
