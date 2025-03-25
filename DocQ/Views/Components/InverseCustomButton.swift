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
    var backgroundColor: Color = Color.white
    var foregroundColor: Color = Color("MainColor")

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }  .buttonStyle(PlainButtonStyle()) // 💡 removes default tap effect spacing
            .frame(maxWidth: .infinity).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("MainColor"), lineWidth: 1)
            )
    }
}


