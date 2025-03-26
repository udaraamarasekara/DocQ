//
//  PatientTabView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct PatientTabView: View {
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

            UserLoginView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Logout")
                }
        }
    }
}
