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
    
    var body: some Scene {
        @EnvironmentObject var sessionManager: SessionManager  // Access the session object
        @State  var navigationPath = NavigationPath()

        WindowGroup {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                NavigationStack(path: $navigationPath) {
                    
                    UserRegistrationView()
                }
                }
        }
    }
}
