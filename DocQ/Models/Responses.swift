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
