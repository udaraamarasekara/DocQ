//
//  NursePatientCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct NursePatientCard: View {
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
                
                HStack{
                    GreenButton(title:"Check in"){}.padding()
                    RedButton(title:"Check out"){}.padding()
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                
                
                
                
            }
        }.padding()
    }
}

#Preview {
    NursePatientCard()
}
