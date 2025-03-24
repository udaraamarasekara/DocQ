//
//  PatientDashboardView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct PatientDashboardView: View {
    var body: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false) {
                ClinicCard()
                
            }
        }
    }
}

#Preview {
    PatientDashboardView()
}
