//
//  ProgressBarView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import SwiftUI

struct ProgressBarView: View {
    
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            // Background
            Circle()
                .stroke(lineWidth: 40)
                .opacity(0.6)
                .foregroundColor(Color("spotPink").opacity(0.2))
            
            // Outer foreground
            Circle()
                .trim(from: 0.0, to: self.progress)
                .stroke(style: StrokeStyle(lineWidth: 38, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("spotPink"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: true)
            
            // Inner foreground
            Circle()
                .trim(from: 0.0, to: self.progress)
                .stroke(style: StrokeStyle(lineWidth: 36, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.white.opacity(0.8))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: true)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    @State static var value = CGFloat(0.3)
    static var previews: some View {
        ProgressBarView(progress: $value)
    }
}
