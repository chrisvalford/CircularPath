//
//  TabBarView.swift
//  CycleTracker
//
//  Created by Christopher Alford on 4/5/22.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTabIndex = 1
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            CycleHistoryView()
                .tabItem {
                    Label("History", systemImage: "list.bullet.circle")
                }.tag(0)
            
            CycleView()
                .tabItem {
                    Label("Current", systemImage: "staroflife.circle")
                }.tag(1)
            
            UserPreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "person.circle")
                }.tag(2)
        }
        .accentColor(Color("spotPink"))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
