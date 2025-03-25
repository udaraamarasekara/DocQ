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
     var viewModel = AuthViewModel()

    var body: some View {
        VStack {
            Image("AppLogo")
            Text("Create Account").font(.title)
            Text("We are here to help you!").opacity(0.5).padding(.bottom)
            CustomTextField(placeholder:"Your Name", text: $username)
            CustomTextField(placeholder: "Your Email", text:$email)
            CustomTextField(placeholder:"Password", text:$password, isSecure: true)
            CustomButton(title:"Create Account" ){viewModel.register(username: username, email:email, password: password
            )}.padding()
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
            }}
        .padding()
        HStack{
            Text("Do you have an account?").opacity(0.5)
            Text("Sign In").bold().foregroundColor(Color("MainColor"))
        }
        
    }
}

#Preview {
    UserRegistrationView()
}
