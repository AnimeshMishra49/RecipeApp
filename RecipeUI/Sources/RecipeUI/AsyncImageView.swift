//
//  AsyncImageView.swift
//  RecipeUI
//
//  Created by Animesh Mishra on 18/5/2025.
//

import SwiftUI
import RecipeKit

public struct AsyncImageView: View {
    public let url: URL
    public let alt: String
    public let placeholderSystemImageName: String

    @State private var image: Image?
    
    public init(url: URL, alt: String, placeholderSystemImageName: String = "fork.knife.circle") {
        self.url = url
        self.alt = alt
        self.placeholderSystemImageName = placeholderSystemImageName
    }

    public var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel(Text(alt))
            } else {
                Image(systemName: placeholderSystemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
                    .opacity(0.4)
                    .accessibilityLabel(Text("Placeholder for \(alt)"))
            }
        }
        .task {
            let service = ImageDataService()
            if let data = await service.load(from: url),
               let uiImage = UIImage(data: data) {
                image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    AsyncImageView(url: URL(string: "/img/salad.jpg")!, alt: "Salad image")
}
