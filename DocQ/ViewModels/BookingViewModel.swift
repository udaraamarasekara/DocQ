//
//  BookingViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-02.
//

import Foundation
class BookingViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var token : String?

    
    func bookSession(sessionId:Int){
        guard let url = URL(string: "\(Api.baseURL)appointment") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token is missing")
            return
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let body: [String: Any] = [
            "session_id": sessionId
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            // Handle network errors
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(AppointmentTokenResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.token =   decodedResponse.token
                        print("ttt")
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }}

