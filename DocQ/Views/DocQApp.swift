//
//  DocQApp.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-23.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct DocQApp: App {
    @StateObject var sessionManager = SessionManager()
    @State  var navigationPath = NavigationPath()
    var body: some Scene {
        
        // Access the session object
        

        WindowGroup {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                NavigationStack(path: $navigationPath) {
                    
                    UserRegistrationView()
                }
            }.environmentObject(sessionManager)
        }
    }
}
