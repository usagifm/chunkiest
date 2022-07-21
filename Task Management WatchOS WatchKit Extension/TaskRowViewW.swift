//
//  TaskRowViewW.swift
//  ChunkistWatch WatchKit Extension
//
//  Created by Rafik Lutfi on 21/07/22.
//

import SwiftUI

struct TaskRowViewW: View {

    var body: some View {
        HStack {
            Text ("Task 1")
            Spacer()
            Image(systemName: "checkmark.circle")
        }
    }
}

struct TaskRowViewW_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowViewW()
    }
}
