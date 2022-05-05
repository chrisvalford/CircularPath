//
//  CycleView+Observed.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/5/22.
//

import Combine
import CoreData
import SwiftUI

extension CycleView {
    class Observed: ObservableObject {
        
        struct RoundView: Identifiable {
            let id: Int
            let point: CGPoint
            var spotColor: Color = .green
        }
        
        @Published var views: [RoundView] = []
        @Published var title: String
        @Published var timerString: String
        @Published var unit: String
        @Published var startDate: Date? {
            didSet { addCycle() }
        }
        @Published var elapsedDays = 0
        
        public var points: [CGPoint] = []
        private var currentCycle: Cycle?
        
//        @Environment(\.managedObjectContext) private var viewContext
//        @FetchRequest(
//            entity: Cycle.entity(),
//            sortDescriptors: [
//                NSSortDescriptor(keyPath: \Cycle.startDate, ascending: false)
//            ]
//        ) var users: FetchedResults<Cycle>

        init() {
            title = "Ovulation in"
            timerString = "03"
            unit = "Days"
        }
        
        // Check the CD store for a cycle which started in the last 28 days
        // Update the elapsedDays value if true
        func hasCurrentCycle() -> Bool {
            guard let current = currentCycle else {
                return false
            }
            if current.isCurrent() {
                elapsedDays = current.elapsedDays()
                return true
            }
            return false
        }
        
        func fetchCurrentCycle() {
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest: NSFetchRequest<Cycle>
            fetchRequest = Cycle.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
            do {
                let objects: [Cycle] = try context.fetch(fetchRequest)
                guard let current = objects.first else {
                    return
                }
                currentCycle = current
                startDate = current.startDate
            } catch {
                print(error)
            }
        }
        
        private func addCycle() {
            // TODO: Check a cycle for this month doesn't already exist
            let context = PersistenceController.shared.container.viewContext
            let cycle = Cycle(context: context)
            cycle.id = UUID()
            cycle.startDate = startDate
            do {
                try context.save()
                currentCycle = cycle
            } catch {
                print(error)
            }
        }
        
        public func addDayObservation(for day: Int) {
            guard let cycle = currentCycle else { return }
            cycle.addDayObservation(for: day)
        }
        
        func createPoints(for metrics: GeometryProxy) {
            drawCirclePoints(quantity: 28,
                             radius: (metrics.size.width * 0.8 / 2),
                             center: CGPoint(x: metrics.size.width / 2,
                                             y: metrics.size.height / 2 - 22))
            // TODO: The Y: -22 above needs to be replaced with the offset caused by the navigation bar
            var index = 0
            for point in points {
                var view = RoundView(id: index, point: point)
                var color: Color
                if 0...3 ~= index {
                    color = Color("spotRed")
                } else if 4...7 ~= index {
                    color = Color("spotPink")
                } else if 8...16 ~= index {
                    color = Color("spotGreen")
                } else if 17...21 ~= index {
                    color = Color("spotPink")
                } else if 22...26 ~= index {
                    color = Color("spotYellow")
                } else {
                    color = Color("spotRed")
                }
                view.spotColor = color
                views.append(view)
                index += 1
            }
        }
        
        public func drawCirclePoints(quantity: Int, radius: CGFloat, center: CGPoint) {
            let slice = 2 * CGFloat.pi / CGFloat(quantity)
            for index in 0..<quantity {
                let angle = (slice * CGFloat(index)) - 1.570796 // - 90 degrees
                let xPosition = (center.x + radius * cos(angle))
                let yPosition = (center.y + radius * sin(angle))
                let point = CGPoint(x: xPosition.rounded(.toNearestOrEven), y: yPosition.rounded(.toNearestOrEven))
                points.append(point)
            }
        }
    }
}
