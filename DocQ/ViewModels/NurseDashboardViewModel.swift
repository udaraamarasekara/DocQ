//
//  NurseDashboardViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//
import Foundation;
import Combine;
import UserNotifications
class NurseDashboardViewModel:ObservableObject{
    @Published var notificationCount: Int = 0
    @Published var isLoggedOut:Bool = false
    @Published var mySessions:[DoctorSessionResponse]=[]
    @Published var isLoading = false
    
    func fetchMySessions(){
        guard let url = URL(string: "\(Api.baseURL)doctorsForClinicNurse") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            // Handle missing token scenario
            print("Token is missing")
            return
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Indicate loading state
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network errors first
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Network error: \(error.localizedDescription)")
                }
                return
            }
            
            // Ensure there is data
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("No data received from the server")
                }
                return
            }
            
            // Handle HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Invalid response")
                }
                return
            }
            
            // Handle successful response (status code 200)
            if httpResponse.statusCode == 200 {
                do {
                    let successResponse = try JSONDecoder().decode([DoctorSessionResponse].self, from: data)
                    DispatchQueue.main.async {
                        // Update the session information
                        self.mySessions = successResponse
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print("Failed to decode the response: \(error.localizedDescription)")
                    }
                }
            } else {
                // Handle non-200 status codes
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Received non-200 response: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }

    
    func logout() {
        guard let url = URL(string: "\(Api.baseURL)logout") else { return }


             var request = URLRequest(url:url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                print("Token is missing")
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            DispatchQueue.main.async {
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoggedOut = true
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
                        _ = try JSONDecoder().decode(SuccessResponse.self, from: data)
                        DispatchQueue.main.async {
                            
                        }
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                    }
                } else {
                    print("Received non-200 response: \(httpResponse.statusCode)")
                }
            }.resume()
        }
        
    
    
}

