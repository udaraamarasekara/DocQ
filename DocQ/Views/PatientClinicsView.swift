//
//  PatientClinicsView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

@available(iOS 16.0, *)
struct PatientClinicsView: View {
    
    @StateObject var viewModel: PatientBookSessionViewModel
    @Binding var path: NavigationPath
    @EnvironmentObject var sessionManager: SessionManager

    @State private var isShowPopup = false
    @State private var tokenCurnt = ""
    @State private var description = ""
    @State private var expanded = false
    
    let clinic: ClinicResponse
    let lineLimit = 3
    
    let rows = [
        GridItem(.fixed(50), spacing: 33),
        GridItem(.fixed(50), spacing: 33)
    ]
    
    init(clinic: ClinicResponse, path: Binding<NavigationPath>) {
        self.clinic = clinic
        self._viewModel = StateObject(wrappedValue: PatientBookSessionViewModel(clinicId: clinic.id))
        self._path = path
    }
    
    var imageUrl: URL? {
        URL(string: "\(Api.imgURL)\(clinic.image)")
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Clinic Image
                AsyncImage(url: imageUrl) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                
                // Clinic Name
                HStack {
                    Text(clinic.name)
                        .font(.system(size: 32, weight: .bold))
                        .padding()
                    Spacer()
                }
                
                // Services
                HStack {
                    Text("Services")
                        .font(.system(size: 32, weight: .bold))
                        .padding()
                    Spacer()
                }
                
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(viewModel.categories, id: \.id) { category in
                        Text(category.name)
                            .frame(width: 100, height: 50)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                
                // Specialized Doctors
                HStack {
                    Text("Specialized Doctors")
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                }.padding()
                
                // Doctors List (Empty ScrollView for now)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(viewModel.doctors, id: \.id) { doctor in
                            DoctorCard(doctor:doctor)
                        }
                        // Add doctor views here
                    }
                }.padding()
                
                // About Section
                HStack {
                    Text("About")
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                }.padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(clinic.description).padding(.horizontal)
                        .lineLimit(expanded ? nil : lineLimit)
                        .animation(.easeInOut, value: expanded)
                    
                    Button(action: {
                        expanded.toggle()
                    }) {
                        Text(expanded ? "View Less" : "View More")
                            .font(.caption)
                            .foregroundColor(Color("MainColor"))
                    }
                }
                
                // Booking Button
                CustomButton(title: "Book Appointment", action: {
                    path.append(Route.bookingView(clinic))
                }).padding()
                
                Spacer()
            }
        }.onAppear(){
            viewModel.fetchCategories()
            viewModel.fetchDoctors()
        }
    }
}
