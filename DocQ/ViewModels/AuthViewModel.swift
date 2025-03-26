//
//  AuthViewModel.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import Foundation;
import SwiftUICore

class AuthViewModel {
    @EnvironmentObject var sessionManager: SessionManager  // Access the session object

    func register(username:String,email:String,password:String) {
        
    }
    func login (email:String,password:String) {
        sessionManager.userRole = "patient"  // Set user role to patient

    }
}
