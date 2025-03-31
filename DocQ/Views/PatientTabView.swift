//
//  PatientTabView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct PatientTabView: View {
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        TabView {
            PatientDashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            PatientSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            if #available(iOS 16.0, *) {
                UserLoginView()
                    .tabItem {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
