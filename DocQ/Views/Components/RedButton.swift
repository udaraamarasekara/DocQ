//
//  RedButton.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

//
//  CustomButton.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct RedButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .red
    var foregroundColor: Color = .white

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity) // Centers the title and stretches it
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default tap effect spacing
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(backgroundColor, lineWidth: 1) // Optional border for the red button
        ).padding(.horizontal)
    }
}
