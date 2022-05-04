//
//  CycleModel.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import Foundation

extension Cycle {
    
    func isCurrent() -> Bool {
        let now = Date.now
        let diffs = Calendar.current.dateComponents([.day], from: self.startDate!, to: now)
        guard let days = diffs.day else {
            return false
        }
        return days < 28
    }
}
