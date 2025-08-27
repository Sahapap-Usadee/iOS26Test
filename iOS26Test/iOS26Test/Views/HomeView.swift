//
//  Untitled.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//
import TipKit
import SwiftUI

struct HomeView: View {
    @State private var showSheet = false
    @State private var selectedColor: Color = .blue
    @State private var showTip = false
    @State private var isToggleOn = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Welcome to iOS 26 Demo 🚀")
                        .font(.largeTitle.bold())
                        .padding(.top)

                    // TipKit (iOS 17+)
                    TipView(TryNewFeaturesTip())

                    Toggle("Enable Feature", isOn: $isToggleOn)
                                           .padding(.horizontal)
                    Text("Toggle is \(isToggleOn ? "ON" : "OFF")")

                    // ShareLink (iOS 16+)
                    ShareLink(item: URL(string: "https://developer.apple.com/")!) {
                        Label("Share Apple Developer", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.borderedProminent)

                    // ColorPicker (iOS 14+)
                    ColorPicker("Pick a color", selection: $selectedColor)
                        .padding(.horizontal)

                    // Grid (iOS 16+)
                    if #available(iOS 16.0, *) {
                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                ForEach(0..<3) { i in
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedColor)
                                        .frame(height: 60)
                                        .overlay(Text("Item \(i+1)").foregroundColor(.white))
                                }
                            }
                        }
                        .padding()
                    }

                    // Sheet presentation (iOS 16+)
                    Button("Show Sheet") {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet) {
                        VStack {
                            Text("This is a sheet!")
                                .font(.title)
                            Button("Dismiss") {
                                showSheet = false
                            }
                        }
                        .presentationDetents([.medium, .large])
                    }

                    // Animation (iOS 15+)
                    AnimatedSymbolView()
                        .frame(height: 80)
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

struct AnimatedSymbolView: View {
    @State private var animate = false

    var body: some View {
        Image(systemName: "star.fill")
            .font(.system(size: 60))
            .foregroundStyle(.yellow)
            .scaleEffect(animate ? 1.3 : 1)
            .rotationEffect(.degrees(animate ? 360 : 0))
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animate = true
                }
            }
    }
}

struct TryNewFeaturesTip: Tip {
    var title: Text {
        Text("Try new features!")
    }
    var message: Text? {
        Text("features in this demo app.")
    }
}
