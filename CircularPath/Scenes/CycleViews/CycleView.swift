//
//  CycleView.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

struct CycleView: View {
    @StateObject private var observed = Observed()
    @State private var selectedDate = Date.now
    @State private var buttonText = "Select your start date"
    @State private var progressValue: CGFloat = 0.0
    @State private var pointsCreated = false
    
    // Navigation
    @State private var showPopUp = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("gradientLight"), Color("gradientDark"), Color("gradientLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    VStack {
                        Button(action: {
                            showPopUp = true
                        }, label: {
                            Text(buttonText)
                        })
                        .frame(minWidth: 100, maxWidth: geometry.size.width * 0.8, minHeight: 44)
                        .background(Color("spotPink"))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        Spacer()
                    }
                    ProgressBarView(progress: self.$progressValue)
                        .frame(width: (geometry.size.width * 0.8), height: (geometry.size.width * 0.8))
                    // FIXME: Only draw on load
//                    if $pointsCreated.wrappedValue == false {
                        ForEach(observed.views) { view in
                            RoundButton(radius: 20, backgroundColor: view.spotColor, function: { somethingTapped(id: view.id) })
                                .position(view.point)
                        }
//                        pointsCreated = true
//                    }
                    Circle()
                        .fill(Color.white)
                        .frame(width: (geometry.size.width * 0.7), height: (geometry.size.width * 0.7))
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
                    .padding(40)
                    
                }
                .navigationTitle("Current Cycle")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear(perform: {
                observed.createPoints(for: geometry)
                observed.fetchCurrentCycle()
                if observed.hasCurrentCycle() {
                    // Yes you can force unwrap as startDate is not optional
                    selectedDate = observed.startDate!
                    progressValue = CGFloat(observed.elapsedDays) * 0.0358
                }
            })
            .onChange(of: selectedDate, perform: { value in
                buttonText = "Started:  \(selectedDate.formatted(date: .abbreviated, time: .omitted))"
                observed.startDate = selectedDate
            })
            if $showPopUp.wrappedValue {
                ZStack {
                    Color.white
                    VStack(spacing: 16) {
                        DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: [.date]) {
                            Text("Start date")
                        }
                        //                        .padding()
                        Button(action: {
                            showPopUp = false
                        }, label: {
                            Text("Done")
                        })
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44)
                        .padding(.horizontal)
                        .background(Color("spotPink"))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                    .padding()
                }
                .frame(width: geometry.size.width, height: 140)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
    
    private func somethingTapped(id: Int) {
        print("You tapped day \(id)")
        observed.addDayObservation(for: id)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CycleView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
