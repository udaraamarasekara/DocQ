//
//  DocQApp.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-23.
//

import SwiftUI

@main
struct DocQApp: App {
    
    var body: some Scene {
        @EnvironmentObject var sessionManager: SessionManager  // Access the session object

        WindowGroup {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                PatientDashboardView().padding(.top,0)
            }
        }
    }
}
