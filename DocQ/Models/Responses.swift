//
//  SuccessResponse.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-28.
//


import Foundation

struct SuccessResponse: Codable {
    let success: String
}

struct ErrorResponse: Codable {
    let error: String
}
struct LoginResponse:Codable {
    let name: String
    let token: String
    let role: String
}

struct AppointmentTokenResponse:Codable {
    let token: String
}
struct SessionResponse: Codable {
    // Define the properties based on the JSON response structure
    var id:Int
    var date: String
    var clinic: String
    var status: String
}


struct AppointmentResponse: Codable,Identifiable {
    var id:Int
    var name: String
    var token: String
    var status: String
}

struct ClinicResponse: Codable,Identifiable,Hashable {
    var id:Int
    var name: String
    var image: String
    var description : String
}
struct CategoryResponse: Codable,Identifiable,Hashable {
    var id:Int
    var name: String
}
struct DoctorResponse: Codable,Identifiable,Hashable {
    var id:Int
    var name: String
    var category:String
    var image: String
}
struct DoctorOrClinicSessionResponse: Codable,Identifiable,Hashable {
    var id:Int
    var name: String
    var status:String
    var date:String
    var image: String
    var  is_booked:Bool
}
