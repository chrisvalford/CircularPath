//
//  ContentView.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var observed = Observed()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("gradientLight"), Color("gradientDark"), Color("gradientLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                ForEach(observed.views) { view in
                    RoundButton(radius: 20, backgroundColor: view.spotColor, function: { somethingTapped() })
                        .position(view.point)
                }

                Circle()
                    .fill(Color.white)
                    .frame(width: (geometry.size.width * 0.65), height: (geometry.size.width * 0.65))

                VStack {
                    Text(observed.title)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                    Text(observed.timerString)
                        .font(.system(size: 90, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    Text(observed.unit)
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                }
            }

            .onAppear(perform: {
                observed.createPoints(for: geometry)
            })
        }
    }

    private func somethingTapped() {
        print("Ouch!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
