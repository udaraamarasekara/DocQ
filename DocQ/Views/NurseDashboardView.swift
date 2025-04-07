//
//  NurseDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


import SwiftUI

@available(iOS 16.0, *)
struct NurseDashboardView: View {
    @StateObject private var viewModel = NurseDashboardViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    @Binding var path:NavigationPath
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            HStack{
                Circle().fill(.yellow).frame(width:50,height:50).overlay(Text(String(sessionManager.name?.prefix(1) ?? "A"))                   .font(.system(size: 32, weight: .bold)) // Custom font size and weight
                ).padding()
                Text(sessionManager.name ?? "").bold()
                
                Spacer()
                if #available(iOS 17.0, *) {
                    Button(action: {
                        viewModel.logout()
                        
                        // Show notification when bell is tapped
                    }){
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                        
                        
                        
                    }.onChange(of:viewModel.isLoggedOut){
                        path.append("login")
                        path = NavigationPath()  // Clears navigation history
                        
                    }
                    .padding()
                } else {
                    // Fallback on earlier versions
                }}
            
            ForEach(viewModel.mySessions ,id:\.id) { session in
                
                DocQueueCard(session:session, path:$path)
            }        }.onAppear(){
                sessionManager.name = UserDefaults.standard.string(forKey: "name")
                sessionManager.role = UserDefaults.standard.string(forKey: "role")
                sessionManager.token = UserDefaults.standard.string(forKey: "token")
               
                viewModel.fetchMySessions()
            
        }
    }
}


