//
//  SuccessBookingPopup.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct SuccessBookingPopup: View {

    @Binding var isPresented: Bool
    var title: String
    var message: String
    var onDismiss: (() -> Void)? = nil

    var body: some View {
        if isPresented {
            GeometryReader { geometry in

            ZStack {
                // Full-screen dimmed background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        dismiss()
                    }.frame(width:geometry.size.width,height:geometry.size.height)

                // Popup content centered using GeometryReader
                    VStack(spacing: 16) {
                        Image("SuccessIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)

                        Text(title)
                            .font(.title)
                            .bold()
                            .padding(.top)

                        Text(message)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .frame(maxWidth: geometry.size.width * 0.8)

                        CustomButton(title: "OK") {
                            dismiss()
                        }
                        .frame(width: geometry.size.width * 0.6, height: 50)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .frame(width: geometry.size.width * 0.85) // Adjust width relative to screen size
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Centering
                }
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
