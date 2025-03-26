//
//  DateSelectorView.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-26.
//

import SwiftUI

struct PatientDateSelectorView: View {
    @State private var selectedDate = Date()
    @State var isPresented: Bool = true
    var body: some View {
        ZStack{
            
            VStack {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date] // Use [.date, .hourAndMinute] for datetime
                )
                .datePickerStyle(.graphical) // <--- This gives a calendar style
                .padding()
                
                if #available(iOS 15.0, *) {
                    Text("Selected: \(selectedDate.formatted(date: .long, time: .omitted))")
                } else {
                    // Fallback on earlier versions
                }
                CustomButton(title:"Book"){}.padding()
            }
           
            
            SuccessBookingPopup(isPresented: $isPresented, title:"title", message: "msg")
            
        }
    }
}

#Preview {
    PatientDateSelectorView()
}
