import SwiftUI

@available(iOS 16.0, *)
struct UserLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var path: NavigationPath  // Receive path for navigation

    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
            VStack {
                if !viewModel.message.isEmpty {
                    Text(viewModel.message)
                        .foregroundColor(viewModel.isError ? .red : .green)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Image("AppLogo")
                Text("Hi Welcome back").font(.title)
                Text("Hope you are doing fine!").opacity(0.5).padding(.bottom)

                CustomTextField(placeholder: "Your Email", text: $email).padding(.horizontal)
                CustomTextField(placeholder: "Password", text: $password, isSecure: true).padding(.horizontal)

                CustomButton(title: "Login") {
                    viewModel.login(email: email, password: password)
                }.onChange(of:viewModel.role){role in path.append(role)}

                .padding(.top)
                .padding(.horizontal)
            }
            .padding()
        
        
    }
}
