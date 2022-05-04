//
//  UserPreferencesView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import SwiftUI

struct UserPreferencesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("gradientLight"), Color("gradientDark"), Color("gradientLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                Text("TODO:")
            }
            .navigationTitle("Your preferences")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView()
    }
}
