//
//  ImageGridView.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 6/10/23.
//

import SwiftUI

struct ImageGridView {
    
    var images: [UIImage]
    var size: CGFloat
    
    init(images: [UIImage], size: CGFloat) {
        self.images = images
        self.size = size
    }
    
    var body: some View {
        let gridItems = [GridItem(.fixed(size), spacing: 3),
                         GridItem(.fixed(size), spacing: 3),
                         GridItem(.fixed(size))]
        return LazyVGrid(columns: gridItems, spacing: 3) {
            ForEach(0..<images.count, id:\.self) { i in
                Image(uiImage: images[i])
                    .resizable()
                    .frame(height: size)
            }
        }
    }
}
