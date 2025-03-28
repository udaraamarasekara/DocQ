//
//  InverseCustomButton.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

struct InverseCustomButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .white
    var foregroundColor: Color = Color("MainColor")

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity) // Keeps the text centered and stretched
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default tap effect spacing
        .overlay(
            RoundedRectangle(cornerRadius: 10) // Slightly adjusted cornerRadius
                .stroke(foregroundColor, lineWidth: 1)
        )
    }
}
