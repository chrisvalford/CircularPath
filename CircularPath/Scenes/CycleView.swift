//
//  CycleView.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

struct CycleView: View {
    @StateObject private var observed = Observed()
    @State private var showPopUp = false
    @State private var selectedDate = Date.now
    @State private var buttonText = "Select your start date"
    
    var body: some View {
        GeometryReader { geometry in
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
            .onChange(of: selectedDate, perform: { value in
                buttonText = "Started:  \(selectedDate.formatted(date: .abbreviated, time: .omitted))"
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
//                .padding()
                .frame(width: geometry.size.width, height: 140)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }

    private func somethingTapped() {
        print("Ouch!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CycleView()
            .environment(\.locale, .init(identifier: "en"))
    }
}