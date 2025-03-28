//
//  NurseDocApointView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//


import SwiftUI

struct NurseDocApointView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            NursePatientCard()
        }
    }
}


#Preview {
    NurseDocApointView()
}
