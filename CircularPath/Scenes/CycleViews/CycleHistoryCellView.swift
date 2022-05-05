//
//  CycleHistoryCellView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import SwiftUI

struct CycleHistoryCellView: View {
    
    var cycle: Cycle
    
    var body: some View {
        HStack {
            Text("Started \(cycle.startDate!, formatter: itemFormatter)")
            Spacer()
            Image(systemName: cycle.isCurrent() ? "staroflife.circle" : "circle")
        }
    }
}

struct CycleHistoryCellView_Previews: PreviewProvider {
    
    static var sample: Cycle = {
        let context = PersistenceController.shared.container.viewContext
        let sample = Cycle(context: context)
        sample.startDate = Date.now
        return sample
    }()
    
    static var previews: some View {
        CycleHistoryCellView(cycle: sample)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
