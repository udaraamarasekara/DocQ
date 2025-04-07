//
//  DoctorDashboard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

@available(iOS 16.0, *)
struct DoctorDashboardView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var viewModel = DoctorDashboardViewModel()
    @Binding var path:NavigationPath

    var body: some View {
        ZStack{
            
            VStack{
                
                ScrollView(.vertical,showsIndicators: false){
                    HStack{
                        Circle().fill(.yellow).frame(width:50,height:50).overlay(Text(String(sessionManager.name?.prefix(1) ?? "A"))                    .font(.system(size: 32, weight: .bold)) // Custom font size and weight
                        ).padding()
                        Text(sessionManager.name ?? "").bold()
                        
                        Spacer()
                        if #available(iOS 17.0, *) {
                            if #available(macOS 14.0, *) {
                                Button(action: {
                                    // Show notification when bell is tapped
                                    viewModel.logout()
                                }){
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 24))
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                }.onChange(of:viewModel.isLoggedOut){
                                    path.append("login")
                                    path = NavigationPath()  // Clears navigation history
                                    
                                }
                            } else {
                                // Fallback on earlier versions
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    }.padding()}
                
                
                
                VStack{
                    HStack{
                        Text("Working time").bold()
                        
                        Spacer()
                    }.padding(.leading)
                    HStack{
                        Text(viewModel.mySession?.date ?? "").foregroundColor(Color.gray)
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
                            Text(viewModel.inAt).font(.system(size: 22, weight: .bold)).foregroundColor(Color.gray)
                            Spacer()
                        }.padding(.bottom).padding(.leading)
                        Spacer()
                    }.frame(width:150, height: 100).background(Color(red: 249/255, green: 249/255, blue: 249/255))
                        .cornerRadius(10).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.mySession?.status=="ongoing" ? Color.green:Color.gray, lineWidth: 1)
                        )
                    
                    VStack{
                        HStack{
                            Text("Today out").foregroundColor(Color.gray)
                            Spacer()
                        }.padding()
                        HStack{
                            Text(viewModel.outAt).font(.system(size: 22, weight: .bold)).foregroundColor(Color.gray)
                            Spacer()
                        }.padding(.bottom).padding(.leading)
                        Spacer()
                    }.frame(width:150, height: 100).background(Color(red: 249/255, green: 249/255, blue: 249/255))
                        .cornerRadius(10).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.mySession?.status=="finished" ? Color.red:Color.gray, lineWidth: 1)
                        )
                }.padding()
                if viewModel.mySession?.status != "finished" {
                    
                    
                    CustomButton(title:viewModel.mySession?.status == "upcoming" ? "Check in":"check out") {
                        if viewModel.mySession?.status == "upcoming" {
                            viewModel.setAvailability(availability:"ongoing")
                        }
                        else{
                            viewModel.setAvailability(availability:"finished")
                        }
                    }.padding()
                }
                HStack{
                    Text("Todays Patient Count ").bold()
                    
                    Spacer()
                }.padding()
                
                ForEach(viewModel.appointments ,id:\.id) { appointment in
                    
                    PatientCard(appointment:appointment)
                }
                if(viewModel.appointments.isEmpty)
                {
                    Text("No Patients yet!").bold().padding()
                }
            }.onAppear(){
                sessionManager.name = UserDefaults.standard.string(forKey: "name")
                sessionManager.role = UserDefaults.standard.string(forKey: "role")
                sessionManager.token = UserDefaults.standard.string(forKey: "token")
                  viewModel.fetchMySession()
                
            }
            NextSessionPopup(isPresented:$viewModel.isShowPopup ,  title: "You Checked out", message: "Load next session?",onDismiss:{viewModel.isShowPopup = false;viewModel.mySession?.status="finished"}, onOk: {viewModel.fetchMySession()})
            // Set the delegate for handling notifications in the foreground
     
        }
        
           }
        }

//#Preview {
//    DoctorDashboardView()
//}
