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
            CustomTextField(placeholder: "Your Email", text:$email)
            CustomTextField(placeholder:"Password", text:$password, isSecure: true)
            CustomButton(title:"Login" ){viewModel.login( email:email, password: password
            )}.padding()
            
                .padding()
           
        }
    }
}

#Preview {
    UserLoginView()
}

