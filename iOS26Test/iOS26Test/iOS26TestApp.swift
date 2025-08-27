//
//  iOS26TestApp.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//

import SwiftUI
import TipKit

@main
struct iOS26TestApp: App {
    init() {
        try? Tips.configure()
        try? Tips.resetDatastore()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
