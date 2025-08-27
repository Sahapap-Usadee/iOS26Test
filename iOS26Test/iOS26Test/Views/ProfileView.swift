//
//  Untitled.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//

import SwiftUI

struct ProfileView: View {
    @State private var showEditSheet = false
    @State private var showPopover = false
    @State private var showShareSheet = false

    // State สำหรับ UI ใหม่
    @State private var selectedSegment = 0
    @State private var sliderValue: Double = 0.5
    @State private var inputText: String = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text("Sahapap User")
                                .font(.title2.bold())
                            Text("iOS Developer")
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button {
                            showEditSheet = true
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .buttonStyle(.borderless)
                        .accessibilityLabel("Edit Profile")
                    }
                    .padding(.vertical)
                }

                // Section สำหรับทดสอบ UI ใหม่
                Section(header: Text("Test New UI")) {
                    Picker("Segment", selection: $selectedSegment) {
                        Text("First").tag(0)
                        Text("Second").tag(1)
                        Text("Third").tag(2)
                    }
                    .pickerStyle(.segmented)

                    HStack {
                        Text("Slide Bar")
                        Slider(value: $sliderValue, in: 0...1)
                    }
                    Text("Slider Value: \(sliderValue, specifier: "%.2f")")

                    TextField("Enter something...", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                    Text("You typed: \(inputText)")
                }

                Section(header: Text("Actions")) {
                    Button {
                        showShareSheet = true
                    } label: {
                        Label("Share Profile", systemImage: "square.and.arrow.up")
                    }
                    .sheet(isPresented: $showShareSheet) {
                        ActivityView(activityItems: ["https://github.com/yourprofile"])
                    }

                    Button {
                        showPopover = true
                    } label: {
                        Label("Show Popover", systemImage: "info.circle")
                    }
                    .popover(isPresented: $showPopover) {
                        VStack(spacing: 16) {
                            Text("Popover Example")
                                .font(.headline)
                            Text("This is a modern popover in iOS 26.")
                            Button("Close") { showPopover = false }
                        }
                        .padding()
                        .frame(width: 300)
                    }
                }

                Section(header: Text("Recent")) {
                    ForEach(1..<4) { i in
                        HStack {
                            Image(systemName: "doc.text")
                                .foregroundStyle(.orange)
                            Text("Document \(i)")
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                // Delete action
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Settings", systemImage: "gearshape") {
                            // Go to settings
                        }
                        Button("Logout", systemImage: "arrow.backward.circle") {
                            // Logout
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showEditSheet) {
                EditProfileSheet()
            }
        }
    }
}

// ... EditProfileSheet และ ActivityView ตามเดิม ...

// MARK: - Edit Profile Sheet
struct EditProfileSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = "Sahapap User"
    @State private var job = "iOS Developer"

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Job")) {
                    TextField("Job", text: $job)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

// MARK: - UIKit ActivityView for Share Sheet
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

