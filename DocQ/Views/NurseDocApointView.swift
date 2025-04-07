//
//  NurseDocApointView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


import SwiftUI

@available(iOS 16.0, *)
struct NurseDocApointView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Binding var path:NavigationPath
    var session:DoctorSessionResponse
    @StateObject var viewModel:NurseDocAppointViewModel=NurseDocAppointViewModel()
    init(path:Binding<NavigationPath>,session:DoctorSessionResponse){
        _path=path
        self.session = session
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            Text("Appointments of \(session.name) \(session.category)").padding()
            ForEach($viewModel.appointments , id:\.id){$appointment in
                NursePatientCard(appointment:$appointment)

            }
        }.onAppear()
        {
            viewModel.fetchAppointments(session_id: session.id)
        }
    }
}



