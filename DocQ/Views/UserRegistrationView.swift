//
//  UserRegistrationView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-23.
//

import SwiftUI

@available(iOS 16.0, *)
struct UserRegistrationView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    @StateObject private var viewModel = AuthViewModel()
    @State private var showDetail = false

    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.message.isEmpty {
                    Text(viewModel.message)
                        .foregroundColor(viewModel.isError ? .red : .green)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Image("AppLogo")
                Text("Create Account").font(.title)
                Text("We are here to help you!").opacity(0.5).padding(.bottom)
                CustomTextField(placeholder: "Your Name", text: $username).padding(.horizontal)
                CustomTextField(placeholder: "Your Email", text: $email).padding(.horizontal)
                CustomTextField(placeholder: "Password", text: $password, isSecure: true).padding(.horizontal)
                
                CustomButton(title: "Create Account") {
                    viewModel.register(username: username, email: email, password: password)
                }
                .padding(.top)
                .padding(.horizontal)

                HStack {
                    VStack { Divider().frame(height: 1).background(Color.gray.opacity(0.4)) }.padding()
                    Text("Or")
                    VStack { Divider().frame(height: 1).background(Color.gray.opacity(0.4)) }.padding()
                }.padding(.horizontal)

                HStack {
                    Text("Do you have an account?").opacity(0.5)
                    Button("Sign In") { showDetail = true }
                        .bold()
                        .foregroundColor(Color("MainColor"))
                }

                NavigationLink("", destination: UserLoginView(), isActive: $showDetail)
                    .hidden()
            }
            .padding()
        }
        
    }
}
