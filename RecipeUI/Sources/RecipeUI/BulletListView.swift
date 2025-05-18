//
//  BulletListView.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import RecipeKit
import DesignSystem

public struct BulletListView: View {
    public let title: String
    public let items: [String]

    public init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .sectionHeaderStyle()

            ForEach(items, id: \.self) { item in
                Text("• \(item)")
            }
        }
    }
}

#Preview {
    BulletListView(title: "Ingredients", items: ["Salt", "Pepper", "Olive Oil"])
}
