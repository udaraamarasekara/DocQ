//
//  SwiftUIView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }.textFieldStyle(.plain)
        .padding(12)
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .foregroundColor(.black)
    }
}


