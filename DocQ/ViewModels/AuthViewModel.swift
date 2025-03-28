//
//  AuthViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import Foundation;
import SwiftUICore

class AuthViewModel:ObservableObject {
    @EnvironmentObject var sessionManager: SessionManager  // Access the session object
    @Published var message: String = ""
      @Published var isError: Bool = false
    func register(username:String,email:String,password:String) {
        guard let url = URL(string: "\(API.baseURL)register") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let body: [String: Any] = [
            "name": username,
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                   
                    self.isError = true
                }
                return
            }
            
            do {
               

                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // Try to decode success response
                        if let successResponse = try? JSONDecoder().decode(SuccessResponse.self, from: data) {
                            DispatchQueue.main.async {
                                self.message = successResponse.success
                                self.isError = false
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.message = "Success response parsing error"
                                self.isError = true
                            }
                        }
                    } else {
                        
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Error response data: \(responseString)")  // Log the error response
                        }

                        // Try to decode error response
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            DispatchQueue.main.async {
                                self.message = errorResponse.error
                                self.isError = true
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.message = "Error response parsing error"
                                self.isError = true
                            }
                        }
                    }
                }

            }
        }.resume()

    }
    func login (email:String,password:String) {
        sessionManager.userRole = "patient"  // Set user role to patient

    }
}
