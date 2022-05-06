//
//  CycleModel.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import Foundation

extension Cycle {

    convenience init?(startDate: Date) {
        let context = PersistenceController.shared.container.newBackgroundContext()
        self.init(context: context)
        self.id = UUID()
        self.startDate = startDate
        do {
            try context.save()
        } catch {
            print(error)
            return nil
        }
    }
    
    func isCurrent() -> Bool {
        let now = Date.now
        let diffs = Calendar.current.dateComponents([.day], from: self.startDate!, to: now)
        guard let days = diffs.day else {
            return false
        }
        return days < 28
    }
    
    func elapsedDays() -> Int {
        let now = Date.now
        return Calendar.current.dateComponents([.day], from: self.startDate!, to: now).day ?? 0
    }
    
    func addDayObservation(for day: Int, temperature: Float? = nil, mood: Int? = nil, discomfort: Int? = nil, flow: Int? = nil) {
        print("Adding a day observation for day: \(day) (started: \(startDate?.description ?? "unknown"))")
    }
}
