//
//  ContentView.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//

import SwiftUI

enum Tabs {
    case home
    case profile
    case settings
    case search
}

struct ContentView: View {
    @State private var selectedTab: Tabs = .home
    @State private var searchString: String = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: .home) {
                HomeView()
            }
            Tab("Profile", systemImage: "person", value: .profile) {
                ProfileView()
            }
            Tab("Settings", systemImage: "gearshape", value: .settings) {
                SettingsView()
            }
            Tab(value: .search, role: .search) {
                SearchView(searchString: $searchString)
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
}
