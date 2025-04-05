//
//  AuthViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import Foundation;
import SwiftUI

@available(iOS 16.0, *)
class AuthViewModel:ObservableObject {
    @Published var message: String = ""
    
    @Published var role: String = ""

      @Published var isError: Bool = false
 
    @Published var isLoggedOut:Bool = false
    func register(username:String,email:String,password:String) {
        guard let url = URL(string: "\(Api.baseURL)register") else { return }
        
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
                                self.message = "Invalid Credintials!"
                                self.isError = true
                            }
                        }
                    }
                }

            }
        }.resume()

    }
    func login (email:String,password:String) {
        guard let url = URL(string: "\(Api.baseURL)login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let body: [String: Any] = [
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
                        if let successResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                            DispatchQueue.main.async {
                                UserDefaults.standard.set(successResponse.name, forKey: "name")
                                UserDefaults.standard.set(successResponse.role, forKey: "role")
                                UserDefaults.standard.set(successResponse.token, forKey: "token")
                                self.role = successResponse.role 
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
                                self.message = "Invalid Crediantials!"
                                self.isError = true
                            }
                        }
                    }
                }

            }
        }.resume()

    }
    
    
}
