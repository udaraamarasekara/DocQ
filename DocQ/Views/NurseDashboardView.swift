//
//  NurseDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


import SwiftUI

struct NurseDashboardView: View {
    @StateObject private var viewModel = NurseDashboardViewModel()
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            HStack{
                Circle().fill(.yellow).frame(width:50,height:50).overlay(Text("A")                    .font(.system(size: 32, weight: .bold)) // Custom font size and weight
                ).padding()
                Text("User name").bold()
                
                Spacer()
                Button(action: {
                    // Show notification when bell is tapped
                    viewModel.sendNotification()
                }){
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                    
                    
                    if viewModel.notificationCount > 0 {
                        Text("\(viewModel.notificationCount)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Circle().fill(Color.red))
                            .offset(x: 10, y: -10)
                    }
                }.padding()}
            
            
            DocQueueCard()
        }
    }
}


#Preview {
    NurseDashboardView()
}
