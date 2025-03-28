//
//  UserLoginView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct UserLoginView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
     var viewModel = AuthViewModel()

    var body: some View {
        VStack {
            Image("AppLogo")
            Text("Hi Welcome back").font(.title)
            Text("Hope you are doing fine!").opacity(0.5).padding(.bottom)
            CustomTextField(placeholder: "Your Email", text:$email).padding(.horizontal)
            CustomTextField(placeholder:"Password", text:$password, isSecure: true).padding(.horizontal)
            CustomButton(title:"Login" ){viewModel.login( email:email, password: password
            )}.padding(.top).padding(.horizontal)
            
           
        }.padding()

    }
}

#Preview {
    UserLoginView()
}

