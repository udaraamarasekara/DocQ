//
//  NursePatientCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct NursePatientCard: View {
    @Binding var appointment:AppointmentResponse
    @StateObject var viewModel = NurseDocAppointViewModel()
    var body: some View {
        HStack{
            if #available(iOS 17.0, *) {
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
                    
                    HStack{
                        GreenButton(title:"Check in"){
                            viewModel.startAppointment(appointment_id:appointment.id)
                        }.onChange(of:viewModel.isCheckedIn){
                            appointment.status = "checking"
                            
                        }.padding().disabled(appointment.status != "pending")
                        RedButton(title:"Check out"){
                            viewModel.endAppointment(appointment_id:appointment.id)
                        }.onChange(of:viewModel.isCheckedOut)
                        {
                            appointment.status = "checked"
                        }.padding().disabled(appointment.status != "checking")
                    }
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.4))
                    
                    
                    
                    
                }
            } else {
                // Fallback on earlier versions
            }
        }.padding()
    }
}


