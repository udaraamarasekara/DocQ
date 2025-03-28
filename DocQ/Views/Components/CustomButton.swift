//
//  CustomButton.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = Color("MainColor")
    var foregroundColor: Color = Color.white

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity) // This stays to center the text within the button
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal) //  Use this instead of .frame
    }
}


