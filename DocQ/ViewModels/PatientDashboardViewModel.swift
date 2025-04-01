//
//  Untitled.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import Foundation;
import Combine;
import UserNotifications
class PatientDashboardViewModel:NSObject,UNUserNotificationCenterDelegate,ObservableObject{
      @Published var notificationCount: Int = 0
       @Published var isLoading = false
    @Published var clinics: [ClinicResponse] = []
    @Published var categories: [CategoryResponse] = []
    @Published var doctors: [DoctorResponse] = []
    func fetchClinics() {
        guard let url = URL(string: "\(Api.baseURL)allClinics") else {
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
                    let decodedResponse = try JSONDecoder().decode([ClinicResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.clinics = decodedResponse
                        print(self.clinics)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    func fetchDoctors() {
        guard let url = URL(string: "\(Api.baseURL)allDoctors") else {
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
                    let decodedResponse = try JSONDecoder().decode([DoctorResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.doctors = decodedResponse
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    
    func fetchCategories() {
        guard let url = URL(string: "\(Api.baseURL)categories") else {
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
                    let decodedResponse = try JSONDecoder().decode([CategoryResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.categories = decodedResponse
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {

                print("Permission granted.")
                completion(true)
            } else {
                print("Permission denied.")
                completion(false)
            }
        }
    }


    func sendNotification() {
        // Request notification permission first
        requestNotificationPermission { granted in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Sample Notification"
                content.body = "This is a local notification triggered by the app."
                content.sound = .default
                
                // Trigger the notification in 0.5 seconds
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // Add the request to the notification center
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                    } else {
                        print("Notification scheduled!")
                    }
                }
            } else {
                print("Notification permission not granted.")
            }
        }
    
        func fetchNotifications() {
            
        }
        }
        
        
        
    
    
}
