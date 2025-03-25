//
//  PatientSearchView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

struct PatientSearchView: View {
    enum Tab {
           case doctors
           case clinics
       }
    @State private var input: String = ""

       @State private var selectedTab: Tab = .doctors
    var body: some View {
        CustomTextField(placeholder:"Search", text:$input ).padding()
        HStack {
            
            VStack{
                Button(action: {
                    selectedTab = .doctors
                }) {
                    Text("Doctors")
                        .fontWeight(selectedTab == .doctors ? .bold : .regular)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                    
                }
                .foregroundColor(Color("MainColor"))
                .padding(.horizontal)
                
                
                
                .padding()
                if
                    selectedTab == .doctors{
                    Rectangle()
                        .fill(Color("MainColor"))
                    .frame(height: 2).padding(.leading)}}
            
            VStack{
                Button(action: {
                    selectedTab = .clinics
                }) {
                    Text("Clinics")
                        .fontWeight(selectedTab == .clinics ? .bold : .regular)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                    
                }
                .foregroundColor(Color("MainColor"))
                .padding(.horizontal)
                
                
                
                .padding()
                if
                    selectedTab == .clinics{
                    Rectangle()
                        .fill(Color("MainColor"))
                    .frame(height: 2).padding(.trailing)}}}
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        ScrollView(.horizontal, showsIndicators: false) {
                            DoctorCard()
                            
                        }
                    }.padding()}
                .tabItem {
                    Text("Doctors")
                }            }
            
        }
}

#Preview {
    PatientSearchView()
}
