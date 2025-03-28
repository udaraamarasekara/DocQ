//
//  UserRegistrationView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-23.
//

import SwiftUI

struct UserRegistrationView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
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
            CustomTextField(placeholder:"Your Name", text: $username).padding(.horizontal)
            CustomTextField(placeholder: "Your Email", text:$email).padding(.horizontal)
            CustomTextField(placeholder:"Password", text:$password, isSecure: true).padding(.horizontal)
            CustomButton(title:"Create Account" ){viewModel.register(username: username, email:email, password: password
            )}.padding(.top).padding(.horizontal)
            HStack{
                VStack{
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.4))
                }.padding()
                
                Text("Or")
                VStack{
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.4))
                }.padding()
            }
            
            HStack{
                Text("Do you have an account?").opacity(0.5)
                Button(action: {
                    
                }) {
                    Text("Sign In").bold().foregroundColor(Color("MainColor"))
                }}
}.padding()
        
    }
}

#Preview {
    UserRegistrationView()
}
