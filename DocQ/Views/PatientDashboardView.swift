//
//  PatientDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

@available(iOS 16.0, *)
struct PatientDashboardView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var viewModel = PatientDashboardViewModel()
    let rows = [
        GridItem(.fixed(50),spacing:33),
        GridItem(.fixed(50),spacing :33)
    ]
    @Binding var path: NavigationPath
    
    var body: some View {
              VStack{
            ScrollView(.vertical,showsIndicators: false){
                HStack{
                    Circle().fill(.yellow).frame(width:50,height:50).overlay(Text(String(sessionManager.name?.prefix(1) ?? "A"))                    .font(.system(size: 32, weight: .bold)) // Custom font size and weight
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
                    } else {
                        // Fallback on earlier versions
                    }}
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(viewModel.categories, id: \.self){ category in
                        VStack
                        {
                            Text(String(category.id))
                                .frame(width: 50,height: 50)
                            
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            Text(category.name).bold()
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
                        HStack{
                            ForEach(viewModel.clinics, id: \.id) { clinic in
                                Button(action:{
                                    path.append(Route.detailsView(clinic))
                                }){
                                ClinicCard(clinic: clinic)
                                }.buttonStyle(PlainButtonStyle())

                            }
                        }
                    }
                }.padding()
                
                HStack{
                    Text("Specilized Doctors ").bold()
                    
                    Spacer()
                }.padding()
                
                
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(viewModel.doctors, id: \.id) { doctor in
                                Button(action:{
                                    path.append(doctor)
                                }){
                                    DoctorCard(doctor: doctor)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }.padding()
            }}
        .onAppear {
            
            sessionManager.name = UserDefaults.standard.string(forKey: "name")
            sessionManager.role = UserDefaults.standard.string(forKey: "role")
            sessionManager.token = UserDefaults.standard.string(forKey: "token")
            viewModel.fetchClinics()
            viewModel.fetchCategories()
            viewModel.fetchDoctors()
            // Set the delegate for handling notifications in the foreground
        }
        }
    }


//#Preview {
//    PatientDashboardView()
//}
