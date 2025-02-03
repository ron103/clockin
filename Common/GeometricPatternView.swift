//
//  GeometricPatternView.swift
//  clockin-time-tracking-tool
//
//  Created by Rohan Waghmare on 02/02/25.

// Views/Common/GeometricPatternView.swift
import SwiftUI

struct GeometricPatternView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                path.move(to: CGPoint(x: 0, y: height * 0.3))
                path.addLine(to: CGPoint(x: width * 0.5, y: 0))
                path.addLine(to: CGPoint(x: width, y: height * 0.3))
                path.addLine(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.closeSubpath()
            }
            .fill(Color.black.opacity(0.7))
        }
    }
}
