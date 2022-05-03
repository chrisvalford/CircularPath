//
//  CycleStartView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 3/5/22.
//

import SwiftUI

struct CycleStartView: View {
    
    @Binding var cycleStartDate: Date
    
    var body: some View {
        DatePicker(selection: $cycleStartDate, in: ...Date(), displayedComponents: [.date]) {
            Text("Start date")
        }
    }
}

struct CycleStartView_Previews: PreviewProvider {
    @State static var cycleStartDate = Date.now
    static var previews: some View {
        CycleStartView(cycleStartDate: $cycleStartDate)
    }
}
