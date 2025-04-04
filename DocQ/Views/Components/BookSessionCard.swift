//
//  BookClinicCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-03.
//
import SwiftUI

struct BookSessionCard: View {
    @StateObject var viewModel = BookingViewModel()
    @Binding var session:DoctorOrClinicSessionResponse  // Remove optional and make private
    @Binding var isShowPopup: Bool  // Remove optional binding
    
    var imageUrl: URL? {
        URL(string: "\(Api.imgURL)\(session.image)")
    }
    
    init(session: Binding<DoctorOrClinicSessionResponse>, isShowPopup: Binding<Bool>) {
        self._session =  session  // Proper State initialization
        self._isShowPopup = isShowPopup  // Binding initialization
    }
    
    var body: some View {
        VStack {
            HStack {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    // Fallback for earlier versions
                    // Consider using Kingfisher or SDWebImageSwiftUI for iOS <15
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                }
                
                VStack {
                    Text(session.name).bold().padding().frame(width: 180, alignment: .leading)
                    Text(session.status).padding(.leading).frame(width: 180, alignment: .leading)
                    Text(session.date).padding(.leading).frame(width: 180, alignment: .leading)
                }
            }
            if session.is_booked {
                InverseCustomButton(title: "Booked") {
                    // You might want to show popup after booking:
                }
                .disabled(true) }
               else{
                InverseCustomButton(title: "Book Now") {
                    viewModel.bookSession(sessionId: session.id)
                    // You might want to show popup after booking:
                    isShowPopup = true
                }
                .disabled(session.status == "finished")
                .opacity(session.status == "finished" ? 0.5 : 1.0)
            }
        }
        .frame(width: 300)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
