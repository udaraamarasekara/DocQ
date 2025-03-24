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
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }  .buttonStyle(PlainButtonStyle()) // 💡 removes default tap effect spacing
            .frame(maxWidth: .infinity)
    }
}

