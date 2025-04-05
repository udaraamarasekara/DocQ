//
//  PatientBookDocView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

@available(iOS 16.0, *)
struct PatientBookDocView: View {
    @StateObject var viewModel: PatientBookSessionViewModel
    @State var isShowPopup: Bool = false
    @State var doctor :DoctorResponse!
    init(doctor:DoctorResponse,path:Binding<NavigationPath>){
        self.doctor = doctor
        _viewModel = StateObject(wrappedValue: PatientBookSessionViewModel(doctorId: doctor.id))
       _path = path
    }
    @Binding var path:NavigationPath
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        ZStack{ VStack{
            Text("Available Sessions of \(doctor.category) Doctor \(doctor.name)")  .font(.system(size: 19, weight: .bold)).padding()
        
            ScrollView(.vertical,showsIndicators: false){
                ForEach($viewModel.sessions, id: \.self){ session in
                    BookSessionCard(session:session, isShowPopup: $isShowPopup,token:$viewModel.tokenCurnt)
                }
            }}
            SuccessBookingPopup(isPresented:$isShowPopup, title:"Booking Placed!", message:"Your token is:\(viewModel.tokenCurnt)",onDismiss:{viewModel.fetchSessions()})
    }
        .onAppear(){
            viewModel.fetchSessions()
        }
    }
}
