//
//  SuccessResponse.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-28.
//


import Foundation

struct SuccessResponse: Decodable {
    let success: String
}

struct ErrorResponse: Decodable {
    let error: String
}
struct LoginResponse: Decodable {
    let name: String
    let token: String
    let role: String
}


struct SessionResponse: Codable {
    // Define the properties based on the JSON response structure
    var id:Int
    var clinic: String
    var date: String
    var status: String
}


struct AppointmentResponse: Codable,Identifiable {
    var id:Int
    var name: String
    var token: String
    var status: String
}
