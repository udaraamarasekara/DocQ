//
//  PatientCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct PatientCard: View {
    private var appointment:AppointmentResponse
    init(appointment : AppointmentResponse){
        self.appointment = appointment
    }
    var body: some View {
        HStack{
            ScrollView(.vertical, showsIndicators: false) {
                HStack{
                    VStack{
                        Text(appointment.name).bold()
                        Text(appointment.token)
                    }
                    Spacer()
                    Text(appointment.status).bold().padding(4)
                        .foregroundColor(Color.green).cornerRadius(10)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                
                
                
                
            }
        }.padding()
    }
}

//#Preview {
//    PatientCard()
//}
