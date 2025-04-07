//
//  DocQApp.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-23.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct DocQApp: App {
    @StateObject var sessionManager = SessionManager()
    @State var path:NavigationPath = NavigationPath()

    var body: some Scene {
        
        // Access the session object
        

        WindowGroup {
            NavigationStack(path:$path) {

           
                UserRegistrationView(path:$path)
                
                    .navigationDestination(for: String.self) { route in
                        switch route {
                        case "doctor":
                            DoctorDashboardView(path:$path)
                                            case "nurse":
                            NurseDashboardView(path:$path)
                        case "patient":
                            PatientDashboardView(path:$path)
                        case "userLogin":
                            UserLoginView(path:$path)
                        default:
                            Text("Unknown Route")
                        }
                    }.navigationDestination(for: DoctorResponse.self){doc in

                        PatientBookDocView(doctor:doc, path:$path)

                            }
                    .navigationDestination(for: DoctorSessionResponse.self){session in

                        NurseDocApointView(path:$path, session:session)

                    }
                    .navigationDestination(for: Route.self){route in

                        switch route {
                                   case .detailsView(let ClinicResponse):
                            PatientClinicsView(clinic:ClinicResponse, path:$path)
                                   case .bookingView(let ClinicResponse):
                            PatientBookClinicView(clinic: ClinicResponse,path:$path)
                                   }
                            }
            
            }.onAppear(){
                requestReminderPermission()
            }            .environmentObject(sessionManager)

        }
    }
}
