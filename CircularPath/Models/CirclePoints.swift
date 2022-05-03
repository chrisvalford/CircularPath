//
//  CirclePoints.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

class CirclePoints {

    public var points: [CGPoint] = []

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
