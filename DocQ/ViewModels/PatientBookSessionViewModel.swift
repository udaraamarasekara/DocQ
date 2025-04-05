//
//  PatientBookClinicViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-03.
//
import Foundation

class PatientBookSessionViewModel:ObservableObject
{
    var clinicId:Int
    var doctorId:Int
    @Published var tokenCurnt :String = ""
    @Published var isLoading = false
    @Published var sessions:[DoctorOrClinicSessionResponse] = []
    @Published var doctors:[DoctorResponse] = []
    @Published var categories:[CategoryResponse] = []
    init(clinicId: Int)
    {
        self.clinicId = clinicId
        self.doctorId = 0
    }
    init(doctorId: Int)
    {
        self.clinicId = 0
        self.doctorId = doctorId
    }
    
    func fetchCategories() {
        guard let url = URL(string: "\(Api.baseURL)categoriesOfClinic/\(self.clinicId)") else {
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
    func fetchDoctors() {
        guard let url = URL(string: "\(Api.baseURL)doctorsForClinic/\(self.clinicId)") else {
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
                        print(self.doctors)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            } else {
                print("Received non-200 response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    
    func fetchSessions() {
        let urlString: String

            if self.doctorId == 0 {
                urlString = "\(Api.baseURL)sessionsForClinic/\(self.clinicId)"
            } else {
                urlString = "\(Api.baseURL)sessionsForDoctor/\(self.doctorId)"
            }

            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

             var request = URLRequest(url:url)
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
                        let decodedResponse = try JSONDecoder().decode([DoctorOrClinicSessionResponse].self, from: data)
                        DispatchQueue.main.async {
                            self.sessions = decodedResponse
                            print(self.sessions)
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
