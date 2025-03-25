//
//  PatientDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct PatientDashboardView: View {
    @StateObject private var viewModel = PatientDashboardViewModel()
    let rows = [
        GridItem(.fixed(50),spacing:33),
        GridItem(.fixed(50),spacing :33)
    ]
    
    
    var body: some View {
        VStack{
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
                        Image(systemName: "bell.fill")
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
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(1...8, id: \.self) { i in
                        VStack
                        {
                            Text("(i)")
                                .frame(width: 50,height: 50)
                            
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            Text("Category").bold()
                        }
                    }
                }
                
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                    }
                }.padding()
                HStack{
                    Text("Recemonded Clinics").bold()
                    
                    Spacer()
                }.padding()
                
                
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        ClinicCard()
                        
                    }
                }.padding()
                
                HStack{
                    Text("Specilized Doctors ").bold()
                    
                    Spacer()
                }.padding()
                
                
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        DoctorCard()
                        
                    }
                }.padding()
            }}
        .onAppear {
                  // Set the delegate for handling notifications in the foreground
            UNUserNotificationCenter.current().delegate = viewModel 
              }
    }
}

#Preview {
    PatientDashboardView()
}
