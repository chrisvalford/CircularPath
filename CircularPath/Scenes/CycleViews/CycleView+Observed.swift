//
//  CycleView+Observed.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/5/22.
//

import Combine
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
        @Published var startDate: Date?
        @Published var elapsedDays = 0
        
        public var points: [CGPoint] = []

        init() {
            title = "Ovulation in"
            timerString = "03"
            unit = "Days"
        }
        
        /*
         GeometryProxy(owner: #6808, _size: #2645, _environment: #6432, _transform: #3384, _position: #2629, _safeAreaInsets: #3440, _seed: 1)
         GeometryProxy(owner: #6808, _size: #2645, _environment: #6432, _transform: #3384, _position: #2629, _safeAreaInsets: #3440, _seed: 1)
         */
        
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
