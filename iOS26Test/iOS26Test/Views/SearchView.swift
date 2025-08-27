//
//  Untitled.swift
//  iOS26Test
//
//  Created by sahapap on 27/8/2568 BE.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchString: String

    // ตัวอย่างข้อมูล
    let items = ["Apple", "Banana", "Orange", "Grape", "Pineapple"]

    var filteredItems: [String] {
        if searchString.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchString) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Search")
            .searchable(text: $searchString, prompt: "Search fruits")
        }
    }
}
