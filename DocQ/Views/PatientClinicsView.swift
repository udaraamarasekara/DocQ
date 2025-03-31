//
//  PatientClinicsView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

struct PatientClinicsView: View {
    @State private var description=""
      let lineLimit=3
    @EnvironmentObject var sessionManager: SessionManager
      @State private var expanded = false
    let rows = [
        GridItem(.fixed(50),spacing:33),
        GridItem(.fixed(50),spacing :33)
    ]
    let imageUrl = URL(string: "https://picsum.photos/400/300")
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
        VStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView() // Optional loading indicator
                }
            } else {
                // Fallback on earlier versions
            }
            HStack{
                Text("Clinic Name").font(.system(size: 32, weight: .bold)).padding()
                Spacer()
            }
            Spacer()
            
            HStack{
                Text("Services").font(.system(size: 32, weight: .bold)).padding()
                Spacer()
            }
            
            LazyHGrid(rows: rows, spacing: 16) {
                ForEach(1...6, id: \.self) { i in
                    VStack
                    {
                        Text("(serviceei)")
                            .frame(width: 100,height: 50)
                        
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        
                    }}    }
            
            HStack{
                Text("Specilized Doctors ").font(.system(size: 32, weight: .bold))
                
                Spacer()
            }.padding()
            
            
            HStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    DoctorCardNoClin()
                    
                }
            }.padding()
            HStack{
                Text("About").font(.system(size: 32, weight: .bold))
                
                Spacer()
            }.padding()
            VStack(alignment: .leading, spacing: 4) {
                Text(description)
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
            CustomButton(title: "Book Appointment", action: {}).padding()
            Spacer()
        }
    }
        
    }
}

#Preview {
    PatientClinicsView()
}
