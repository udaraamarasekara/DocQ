//
//  NurseDocAppointViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-05.
//

import Foundation;
import Combine;
import UserNotifications
class NurseDocAppointViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var isCheckedIn = false
    @Published var isCheckedOut = false
    @Published var appointments: [AppointmentResponse] = []
    func fetchAppointments(session_id:Int) {
        guard let url = URL(string: "\(Api.baseURL)appointments/\(session_id)") else {
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
    func startAppointment(appointment_id:Int) {
        guard let url = URL(string: "\(Api.baseURL)startAppointment/\(appointment_id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                    _ = try JSONDecoder().decode(SuccessResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isCheckedIn = true
                        
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    func endAppointment(appointment_id:Int) {
        guard let url = URL(string: "\(Api.baseURL)endAppointment/\(appointment_id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                    _ = try JSONDecoder().decode(SuccessResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isCheckedOut = true
                        
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
