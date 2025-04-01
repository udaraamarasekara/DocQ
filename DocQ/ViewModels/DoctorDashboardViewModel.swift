//
//  DoctorDashboardViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


//
//  Untitled.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//
import Foundation
import Combine
import UserNotifications
import SwiftUI
import CoreData
class DoctorDashboardViewModel:ObservableObject {
    @Published var notificationCount: Int = 0
    @Published var mySession :SessionResponse?
    @Published var appointments:[AppointmentResponse]=[]
    @Published var isLoading = false
    @Published var inAt = ""
    @Published var outAt = ""
    @Published var isShowPopup=false

    


   

    
    func setAvailability(availability:String) {
        let sessionId = mySession?.id ?? 0
        guard let url = URL(string: "\(Api.baseURL)setSessionAvailability/\(sessionId)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token is missing")
            return
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "availability": availability,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                   
                }
                return
            }
            
            do {
               

                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // Try to decode success response
                        if (try? JSONDecoder().decode(SuccessResponse.self, from: data)) != nil {print("ok")
                            DispatchQueue.main.async {
                                if self.mySession?.status=="ongoing" { self.isShowPopup = true
                                    
                                }else{
                                    self.fetchMySession()
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                            }
                        }
                    } else {
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Error response data: \(responseString)")  // Log the error response
                        }

                        // Try to decode error response
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            DispatchQueue.main.async {
                                print("nok")

                            }
                        } else {
                            DispatchQueue.main.async {
                                print("nok")

                            }
                        }
                    }
                }

            }
        }.resume()

    }
    
    
    func myAppointments() {
        let session = mySession?.id ?? 0
        guard let url = URL(string: "\(Api.baseURL)appointments/\(session)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                    let decodedResponse = try JSONDecoder().decode([AppointmentResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.appointments = decodedResponse
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    func fetchMySession() {
        guard let url = URL(string: "\(Api.baseURL)mySession") else {
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
                    let successResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Update the session information
                        self.mySession = successResponse
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


 

  
    
}
