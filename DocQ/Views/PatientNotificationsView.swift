//
//  PatientNotificationsView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
import SwiftUI

struct PatientNotificationsView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        HStack{
            Image(systemName: "arrow.left")
                .font(.system(size: 24))
                .foregroundColor(.black)
            Text("Notifications")
            Spacer()
        }.padding()
        
               ScrollView(.vertical,showsIndicators: false){
            Notification()
        }
    }
}


#Preview {
    PatientNotificationsView()
}
