//
//  PatientBookDocView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-25.
//

import SwiftUI

struct PatientBookDocView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            BookDocCard()
        }
    }
}

#Preview {
    PatientBookDocView()
}
