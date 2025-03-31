//
//  NextSessionPopup.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-31.
//

//
//  SuccessBookingPopup.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct NextSessionPopup: View {
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var onDismiss: (() -> Void)? = nil
    var onOk: (() -> Void)? = nil
     
    var body: some View {
        if isPresented {
            ZStack {
                // Dimmed background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        dismiss()
                    }

                // Popup content
                VStack(spacing: 16) {
                                     Text(title)
                        .font(.headline)
                        .padding(.top)
                    Text(message)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    CustomButton(title:"Yes") {
                        dismiss()
                    }
                    InverseCustomButton(title:"No") {
                        dismiss()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 20)
                .padding(.horizontal, 40)
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }

    private func dismiss() {
        isPresented = false
        onDismiss?()
    }
}

