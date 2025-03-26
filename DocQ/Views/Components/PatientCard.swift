//
//  PatientCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct PatientCard: View {
    var body: some View {
        HStack{
            ScrollView(.vertical, showsIndicators: false) {
                HStack{
                    VStack{
                        Text("Patient name").bold()
                      Text("token")
                    }
                    Spacer()
                    Text("Status").bold().padding(4)
                        .foregroundColor(Color.green).cornerRadius(10)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                
                
                
                
            }
        }.padding()
    }
}

#Preview {
    PatientCard()
}
