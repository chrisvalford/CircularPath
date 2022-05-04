//
//  CycleHistoryView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import SwiftUI

struct CycleHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Cycle.startDate, ascending: false)],
        animation: .default)
    private var cycles: FetchedResults<Cycle>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("gradientLight"), Color("gradientDark"), Color("gradientLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                List {
                    ForEach(cycles) { cycle in
                        CycleHistoryCellView(cycle: cycle)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Cycle History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { cycles[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CycleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CycleHistoryView()
    }
}
