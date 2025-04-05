//
//  NurseDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


import SwiftUI

struct NurseDashboardView: View {
    @StateObject private var viewModel = NurseDashboardViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            HStack{
                Circle().fill(.yellow).frame(width:50,height:50).overlay(Text(String(sessionManager.name?.prefix(1) ?? "A"))                   .font(.system(size: 32, weight: .bold)) // Custom font size and weight
                ).padding()
                Text(sessionManager.name ?? "").bold()
                
                Spacer()
                Button(action: {
                    // Show notification when bell is tapped
                }){
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                    
                    
                   
                }.padding()}
            
            
            DocQueueCard()
        }.onAppear(){
            
        }
    }
}


#Preview {
    NurseDashboardView()
}
