//
//  Untitled.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    @State private var showSheet = false
    @State private var showFullScreen = false
    @State private var showPopover = false
    @State private var showAlert = false
    @State private var showDialog = false
    @State private var showMenu = false
    @State private var showShareSheet = false
    @State private var popoverAnchor: CGRect = .zero
    @State private var path = NavigationPath() // เพิ่มสำหรับ push

    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section(header: Text("Navigation")) {
                    Button("Push to Detail Page") {
                        path.append("detail")
                    }
                }

                Section(header: Text("Present View Actions")) {
                    Button("Present Sheet") {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet) {
                        VStack(spacing: 20) {
                            Text("This is a Sheet!")
                                .font(.title)
                            Button("Dismiss") { showSheet = false }
                        }
                        .presentationDetents([.medium, .large])
                    }

                    Button("Present FullScreenCover") {
                        showFullScreen = true
                    }
                    .fullScreenCover(isPresented: $showFullScreen) {
                        VStack(spacing: 20) {
                            Text("Full Screen Cover")
                                .font(.title)
                            Button("Dismiss") { showFullScreen = false }
                        }
                    }

                    Button("Present Popover") {
                        showPopover = true
                    }
                    .popover(isPresented: $showPopover) {
                        VStack(spacing: 16) {
                            Text("Popover Example")
                                .font(.headline)
                            Text("This is a popover")
                            Button("Close") { showPopover = false }
                        }
                        .padding()
                        .frame(width: 300)
                    }
                }

                Section(header: Text("Alert & Dialog Actions")) {
                    Button("Show Alert") {
                        showAlert = true
                    }
                    .alert("Test Alert", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("This is a test alert.")
                    }

                    Button("Show Confirmation Dialog") {
                        showDialog = true
                    }
                    .confirmationDialog("Choose an Option", isPresented: $showDialog, titleVisibility: .visible) {
                        Button("Option 1") {}
                        Button("Option 2") {}
                        Button("Cancel", role: .cancel) {}
                    }
                }

                Section(header: Text("Other Actions")) {
                    Menu("Show Menu") {
                        Button("Menu Option 1") {}
                        Button("Menu Option 2") {}
                        Button("Menu Option 3") {}
                    }

                    ShareLink(item: URL(string: "https://developer.apple.com")!) {
                        Label("Share Apple Developer", systemImage: "square.and.arrow.up")
                    }

                    Link("Open Apple", destination: URL(string: "https://apple.com")!)
                }
            }
            .navigationTitle("Settings")
            .navigationDestination(for: String.self) { value in
                if value == "detail" {
                    DetailNavigationBarView()
                }
            }
        }
    }
}

// เพิ่มหน้าใหม่สำหรับทดสอบ Navigation Bar
struct DetailNavigationBarView: View {
    @State private var showSheet = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 24) {
            Text("This is the detail page.")
                .font(.title)
            Button("Show Sheet") { showSheet = true }
            Button("Show Alert") { showAlert = true }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Detail")
                        .font(.headline)
                    Text("Subtitle Example")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                Text("Sheet from Detail Page")
                    .font(.title2)
                Button("Dismiss") { showSheet = false }
            }
            .presentationDetents([.medium, .large])
        }
        .alert("Hello", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}
