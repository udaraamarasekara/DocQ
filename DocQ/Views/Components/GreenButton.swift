//
//  GreenButton.swift
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

struct GreenButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .green
    var foregroundColor: Color = .white

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity).padding(.horizontal)
    }
}
