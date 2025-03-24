//
//  ClinicCard.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-24.
//

import SwiftUI

struct ClinicCard: View {
    let imageUrl = URL(string: "https://picsum.photos/400/300")
    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView() // Optional loading indicator
                }
                .frame(width: 200, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            } else {
                // Fallback on earlier versions
            }
            HStack{
                Text("Hospital Name").padding().frame(width:200,alignment: .leading)
                
            }
        }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

#Preview {
    ClinicCard()
}
