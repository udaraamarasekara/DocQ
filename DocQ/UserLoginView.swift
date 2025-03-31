import SwiftUI

@available(iOS 16.0, *)
struct UserLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        NavigationStack(path: $viewModel.path) {
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
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .padding()
            .navigationDestination(for: String.self) { route in
                switch route {
                case "doctor":
                    DoctorDashboardView()
//                case "nurse":
//                    NurseDashboardView()
                case "patient":
                    PatientTabView()
                default:
                    Text("Unknown Route")
                }
            }
        }
    }
}
