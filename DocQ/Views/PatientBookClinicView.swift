//
//  PatientBookClinicView.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-03.
//

import SwiftUI

@available(iOS 16.0, *)
struct PatientBookClinicView: View {
    @StateObject var viewModel: PatientBookSessionViewModel
    @State var isShowPopup: Bool = false
    @State var tokenCurnt :String = ""
    @State var clinic :ClinicResponse!
    init(clinic:ClinicResponse,path:Binding<NavigationPath>){
        self.clinic = clinic
        _viewModel = StateObject(wrappedValue: PatientBookSessionViewModel(clinicId: clinic.id))
       _path = path
    }
    @Binding var path:NavigationPath
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        ZStack{ VStack{
            Text("Available Sessions of Clinic \(clinic.name)")  .font(.system(size: 19, weight: .bold)).padding()
        
            ScrollView(.vertical,showsIndicators: false){
                ForEach($viewModel.sessions, id: \.self){ session in
                    BookSessionCard(session:session, isShowPopup: $isShowPopup)
                }
            }}
            SuccessBookingPopup(isPresented:$isShowPopup, title:"Booking Placed!", message:"Your token is:\(tokenCurnt)",onDismiss:{viewModel.fetchSessions()})
    }
        .onAppear(){
            viewModel.fetchSessions()
        }
    }
}

