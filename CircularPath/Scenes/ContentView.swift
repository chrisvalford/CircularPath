//
//  ContentView.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

struct RoundView: Identifiable {
    let id: Int
    let point: CGPoint
    var spotColor: Color = .green
}

struct ContentView: View {

    @State var views: [RoundView] = []
    @ObservedObject var viewModel = CycleModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("gradientLight"), Color("gradientDark"), Color("gradientLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                ForEach(views) { view in
                    RoundButton(radius: 20, backgroundColor: view.spotColor, function: { somethingTapped() })
                        .position(view.point)
                }

                Circle()
                    .fill(Color.white)
                    .frame(width: (geometry.size.width * 0.65), height: (geometry.size.width * 0.65))

                VStack {
                    Text(viewModel.title)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                    Text(viewModel.timerString)
                        .font(.system(size: 90, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    Text(viewModel.unit)
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                }
            }

            .onAppear(perform: {
                let graphics = CirclePoints()
                graphics.drawCirclePoints(quantity: 28, radius: (geometry.size.width * 0.8 / 2), center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                var index = 0
                for point in graphics.points {
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
