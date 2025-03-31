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
//    func fetchClinics() {
//            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//
//            isLoading = true
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//            
//            if let data = data {
//                do {
//                    let decodedPosts = try JSONDecoder().decode([ClinicModel].self, from: data)
//                    DispatchQueue.main.async {
//                        self.clinics = decodedPosts
//                    }
//                } catch {
//                    print("Error decoding posts: \(error)")
//                }
//            } else if let error = error {
//                print("Error fetching posts: \(error)")
//            }
//         }.resume()
//        }
//    
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
