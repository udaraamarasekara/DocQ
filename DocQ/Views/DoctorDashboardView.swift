//
//  DoctorDashboard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct DoctorDashboardView: View {
    
    @StateObject private var viewModel = DoctorDashboardViewModel()
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
                
                
              
                VStack{
                    HStack{
                        Text("Working time").bold()
                        
                        Spacer()
                    }.padding(.leading)
                    HStack{
                        Text(viewModel.getCurrentDateString()).foregroundColor(Color.gray)
                        Spacer()
                    }.padding(.leading)
                }.padding()
                
                HStack{
                    VStack{
                        HStack{
                            Text("Today in").foregroundColor(Color.gray)
                            Spacer()
                        }.padding()
                        HStack{
                            Text("11.00 ").font(.system(size: 22, weight: .bold)).foregroundColor(Color.gray)
                            Spacer()
                        }.padding(.bottom).padding(.leading)
                        Spacer()
                    }.frame(width:150, height: 100).background(Color(red: 249/255, green: 249/255, blue: 249/255))
                        .cornerRadius(10).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 1)
                        )
                    
                    VStack{
                        HStack{
                            Text("Today out").foregroundColor(Color.gray)
                            Spacer()
                        }.padding()
                        HStack{
                            Text("11.00 ").font(.system(size: 22, weight: .bold)).foregroundColor(Color.gray)
                            Spacer()
                        }.padding(.bottom).padding(.leading)
                        Spacer()
                    }.frame(width:150, height: 100).background(Color(red: 249/255, green: 249/255, blue: 249/255))
                        .cornerRadius(10).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 1)
                        )
                }.padding()
                CustomButton(title:"Check in") {
                    
                }.padding()
                HStack{
                    Text("Todays Patient Count ").bold()
                    
                    Spacer()
                }.padding()
                
                
                PatientCard()
            }}
        .onAppear {
            // Set the delegate for handling notifications in the foreground
            
        }}      }

#Preview {
    DoctorDashboardView()
}
