//
//  ImageRenderHelper.swift
//  WhatDog
//
//  Created by Sneha Seenuvasavarathan on 4/9/23.
//

import SwiftUI

final class ImageRenderHelper {
    static let cornerRadius: CGFloat = 20
    static func computeDimensions(for image: UIImage, maxWidth: CGFloat = 500) -> (CGFloat, CGFloat) {
        let ratio = image.size.height/image.size.width
        if ratio < 1 {
            return (maxWidth * ratio, maxWidth)
        }
        return (maxWidth, maxWidth/ratio)
    }
}
